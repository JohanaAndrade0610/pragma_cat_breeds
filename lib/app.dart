/*
 * @class App
 * @description Clase encargada de contener la aplicación.
 * @autor Angela Andrade
 * @version 1.0 08/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'di/injection.dart';
import 'core/connectivity/connectivity_handler.dart';
import 'core/connectivity/connectivity_service.dart';
import 'core/locale_notifier.dart';
import 'core/theme_mode_notifier.dart';
import 'l10n/app_localizations.dart';
import 'features/favorites/data/datasource/favorites_sqlite_datasource.dart';
import 'features/favorites/data/repositories/favorites_repository_impl.dart';
import 'features/favorites/presentation/cubit/favorites_cubit.dart';

// Servicio de conectividad para toda la aplicación
final ConnectivityService _connectivityService = ConnectivityService();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Configuración del router
    final router = AppRouter.instance.router;
    // Providers de los cubits para la gestión del estado de la aplicación
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (_) => getIt<HomeCubit>()),
        BlocProvider<FavoritesCubit>(
          create: (_) => FavoritesCubit(
            FavoritesRepositoryImpl(FavoritesSqliteDatasource()),
          ),
        ),
      ],
      // Retornar la aplicación con el router configurado, temas e idiomas de la aplicación
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeModeNotifier,
        builder: (context, mode, _) {
          return ValueListenableBuilder<Locale>(
            valueListenable: localeNotifier,
            builder: (context, locale, _) {
              return MaterialApp.router(
                title: 'pragma_cat_breeds',
                theme: ThemeData.light().copyWith(
                  scaffoldBackgroundColor: Colors.white,
                ),
                // Gris personalizado para el modo oscuro
                darkTheme: ThemeData.dark().copyWith(
                  scaffoldBackgroundColor: const Color(
                    0xFF292A36,
                  ),
                ),
                themeMode: mode,
                locale: locale,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                routerConfig: router,
                // Manejo de la conectividad en toda la aplicación
                builder: (context, child) => ConnectivityHandler(
                  service: _connectivityService,
                  child: child!,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
