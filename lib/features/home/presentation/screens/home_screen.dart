/*
 * @class HomeScreen
 * @description Clase encargada de mostrar la pantalla principal de la aplicación.
 * @author Angela Andrade
 * @version 1.0 08/10/2025 Creación y documentación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home_cubit.dart';
import '../../../../core/locale_notifier.dart';

import '../../../../core/theme_mode_notifier.dart';
import '../../../../core/widgets/custom_footer.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/cat_breed_card.dart';
import '../widgets/cat_breed_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controlador de texto para el campo de búsqueda
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    // Control de localización para multiples idiomas
    final l10n = AppLocalizations.of(context)!;
    // Control de tema oscuro/claro
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Color del campo de búsqueda según el tema
    final inputFillColor = isDark
        ? const Color(0xFF323344)
        : const Color(0xFFFAFBFD);
    // Control de la ubicación actual para el BottomNavigationBar
    final location = GoRouter.of(context).location;
    int selectedIndex = 0;
    if (location == '/favorites')
      selectedIndex = 1;
    else if (location == '/support')
      selectedIndex = 2;

    return Scaffold(
      // AppBar generico de la aplicación
      appBar: CustomAppBar(
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo de Cat Breeds
            Center(
              child: Image.asset(
                isDark
                    ? 'assets/images/cat_breeds_logo_dark_mode.png'
                    : 'assets/images/cat_breeds_logo_light_mode.png',
                height: MediaQuery.of(context).size.height * 0.1,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 19),
            // Campo de búsqueda
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: CatBreedSearchBar(
                initialValue: _searchText,
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                  });
                },
                hintText: l10n.home_input_filter,
                fillColor: inputFillColor,
              ),
            ),
            const SizedBox(height: 15),
            // Cards de razas de gatos
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoaded) {
                    final filteredBreeds = _searchText.isEmpty
                        ? state.breeds
                        : state.breeds.where((b) {
                            final query = _searchText.toLowerCase();
                            final name = b.name.toLowerCase();
                            final origin = (b.origin ?? '').toLowerCase();
                            final weight = (b.weight ?? '').toLowerCase();
                            final weightWithUnit =
                                ((b.weight ?? '-') +
                                        ' ' +
                                        l10n.home_card_kilograms)
                                    .toLowerCase();
                            return name.contains(query) ||
                                origin.contains(query) ||
                                weight.contains(query) ||
                                weightWithUnit.contains(query);
                          }).toList();
                    if (filteredBreeds.isEmpty) {
                      final Color secondaryTextColor = isDark
                          ? Color(0xFFB0B0C3)
                          : Colors.black87;
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            l10n.home_no_results,
                            style: TextStyle(
                              fontSize: 12,
                              color: secondaryTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    return ListView(
                      children: [
                        ...filteredBreeds
                            .map(
                              (b) => CatBreedCard(
                                breed: b,
                                searchText: _searchText,
                              ),
                            )
                            .toList(),
                      ],
                    );
                  } else if (state is HomeError) {
                    return Center(child: Text('Error: ${state.message}'));
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
        selectedIndex: selectedIndex,
        onItemTapped: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/favorites');
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
