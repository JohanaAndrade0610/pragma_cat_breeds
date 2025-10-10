/*
 * @class FavoritesScreen
 * @description Clase encargada de mostrar la pantalla de favoritos.
 * @autor Angela Andrade
 * @version 1.0 09/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme_mode_notifier.dart';
import '../../../../core/locale_notifier.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_footer.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';

import '../widgets/favorite_cat_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    // Control de localización para multiples idiomas
    final l10n = AppLocalizations.of(context)!;
    // Asignacion modo oscuro
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Color de texto dependiendo del modo aplicado
    final Color secondaryTextColor = isDark
        ? Color(0xFFB0B0C3)
        : Colors.black87;
    return Scaffold(
      // Appbar generico de la aplicación
      appBar: CustomAppBar(
        showBack: false,
        onThemeTap: () {
          // Control modo claro/oscuro
          themeModeNotifier.value = themeModeNotifier.value == ThemeMode.light
              ? ThemeMode.dark
              : ThemeMode.light;
        },
        onLanguageTap: () {
          // Control cambio de idioma
          localeNotifier.value = localeNotifier.value.languageCode == 'en'
              ? const Locale('es')
              : const Locale('en');
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo de la aplicación
            Center(
              child: Image.asset(
                isDark
                    ? 'assets/images/cat_breeds_logo_dark_mode.png'
                    : 'assets/images/cat_breeds_logo_light_mode.png',
                height: MediaQuery.of(context).size.height * 0.1,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            // Cards de gatos favoritos
            Expanded(
              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  if (state is FavoritesLoaded && state.favorites.isNotEmpty) {
                    final favorites = state.favorites;
                    return GridView.builder(
                      itemCount: favorites.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 18,
                            crossAxisSpacing: 18,
                            childAspectRatio: 1.1,
                          ),
                      itemBuilder: (context, index) {
                        final cat = favorites[index];
                        return FavoriteCatCard(cat: cat);
                      },
                    );
                  } else if (state is FavoritesLoaded &&
                      state.favorites.isEmpty) {
                    // Caja vacía cuando no hay favoritos
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.19,
                        ),
                        // Imagen de caja vacía
                        Image.asset(
                          'assets/images/empty_box.png',
                          height: MediaQuery.of(context).size.height * 0.15,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 16),
                        //Texto "No hay gatos marcados como favoritos"
                        Text(
                          l10n.favorites_no_favorites,
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      // Footer generico de la aplicación
      bottomNavigationBar: CustomFooter(
        selectedIndex: 1,
        onItemTapped: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              // Ventana de favoritos
              break;
            case 2:
              context.go('/support');
              break;
          }
        },
      ),
    );
  }
}
