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
import '../../../home/domain/entities/cat_breeds_entity.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_footer.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';

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
                'assets/images/cat_breeds_logo2.png',
                height: MediaQuery.of(context).size.height * 0.1,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 15),
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
                        return _FavoriteCatCard(cat: cat);
                      },
                    );
                  } else if (state is FavoritesLoaded &&
                      state.favorites.isEmpty) {
                    // Control para cuando no hay favoritos
                    return Center(child: Text(l10n.favorites_no_favorites));
                  }
                  return const Center(child: CircularProgressIndicator());
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

// Diseño del card individual para cada gato favorito
class _FavoriteCatCard extends StatelessWidget {
  final CatBreedsEntity cat;

  const _FavoriteCatCard({required this.cat});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoritesCubit>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6529CD).withOpacity(0.13),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Imagen del gato
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child: cat.imageUrl != null
                  ? Image.network(
                      cat.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.pets,
                          size: 40,
                          color: Color(0xFF6529CD),
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.pets,
                        size: 40,
                        color: Color(0xFF6529CD),
                      ),
                    ),
            ),
          ),
          // Nombre y corazón
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    cat.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await cubit.toggleFavorite(cat);
                  },
                  child: Icon(
                    Icons.favorite,
                    color: Color(0xFF6529CD),
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
