/*
 * @class CatBreedDetailScreen
 * @description Clase encargada de mostrar los detalles de una raza de gato.
 * @author Angela Andrade
 * @version 1.0 09/10/2025 Creación y documentación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_divider.dart';
import '../../../../core/widgets/custom_footer.dart';
import '../../../../core/theme_mode_notifier.dart';
import '../../../../core/locale_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../favorites/presentation/cubit/favorites_cubit.dart';
import '../../../favorites/presentation/cubit/favorites_state.dart';
import '../../domain/entities/cat_breeds_entity.dart';
import '../widgets/cat_breed_detail_row.dart';
import '../widgets/cat_breed_detail_stars_row.dart';

class CatBreedDetailScreen extends StatefulWidget {
  // Raza de gato a mostrar
  final CatBreedsEntity breed;
  const CatBreedDetailScreen({Key? key, required this.breed}) : super(key: key);

  @override
  State<CatBreedDetailScreen> createState() => _CatBreedDetailScreenState();
}

class _CatBreedDetailScreenState extends State<CatBreedDetailScreen>
    with WidgetsBindingObserver {
  /*
    * @method initState
    * @description Método encargado de inicializar el estado de la pantalla.
    */
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Cargar razas favoritas al inicializar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesCubit>().loadFavorites();
    });
  }

  /*
    * @method dispose
    * @description Método encargado de limpiar los recursos utilizados por la pantalla.
    */
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /*
    * @method didChangeAppLifecycleState
    * @description Método encargado de manejar los cambios en el estado del ciclo de vida de la aplicación.
    * @param state - Estado actual del ciclo de vida de la aplicación.
    */
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Cuando la app regresa al primer plano, recargar favoritos
    if (state == AppLifecycleState.resumed && mounted) {
      context.read<FavoritesCubit>().loadFavorites();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Control de localización para multiples idiomas
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      // AppBar genérico de la aplicación
      appBar: CustomAppBar(
        showBack: true,
        onBack: () => Navigator.of(context).pop(),
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
      body: Center(
        // Diseño del card principal
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6529CD).withOpacity(0.25),
                blurRadius: 6,
                spreadRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Nombre de la raza y opción de añadir a favoritos
                BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, state) {
                    bool isFav = false;
                    if (state is FavoritesLoaded) {
                      isFav = state.favorites.any(
                        (cat) => cat.id == widget.breed.id,
                      );
                    }
                    final cubit = context.read<FavoritesCubit>();
                    return Row(
                      children: [
                        Expanded(
                          // Nombre de la raza y su ID
                          child: Text(
                            '${widget.breed.name} (${widget.breed.id})',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        // Icono de favorito
                        GestureDetector(
                          onTap: () async {
                            await cubit.toggleFavorite(widget.breed);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6529CD).withOpacity(0.13),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: const Color(0xFF6529CD),
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                // Imagen de la raza
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 15.0,
                    bottom: 15.0,
                  ),
                  child: widget.breed.imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: double.infinity,
                            height: 160,
                            child: Image.network(
                              widget.breed.imageUrl!,
                              fit: BoxFit.contain,
                              errorBuilder: (c, e, s) => Container(
                                color: Colors.grey[200],
                                child: Icon(
                                  Icons.pets,
                                  size: 40,
                                  color: Color(0xFF6529CD),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          alignment: Alignment.center,
                          height: 120,
                          child: Icon(
                            Icons.pets,
                            size: 40,
                            color: Color(0xFF6529CD),
                          ),
                        ),
                ),
                // Información detallada de la raza
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sección: Información general
                        const CustomDivider(
                          thickness: 0.5,
                          margin: EdgeInsets.symmetric(vertical: 10),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Color(0xFF6529CD),
                              size: 16,
                            ),
                            SizedBox(width: 6),
                            Text(
                              l10n.details_general_information,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6529CD),
                              ),
                            ),
                          ],
                        ),
                        const CustomDivider(
                          thickness: 0.5,
                          margin: EdgeInsets.symmetric(vertical: 10),
                        ),
                        // Descripción de la raza
                        buildInfoRow(
                          l10n.details_description,
                          widget.breed.description,
                        ),
                        // Origen de la raza
                        buildInfoRow(
                          l10n.details_card_origin,
                          widget.breed.origin,
                        ),
                        // Enlace a Wikipedia
                        widget.breed.wikipediaUrl != null &&
                                widget.breed.wikipediaUrl!.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    l10n.details_wikipedia,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  GestureDetector(
                                    onTap: () async {
                                      final url = Uri.parse(
                                        widget.breed.wikipediaUrl!,
                                      );
                                      if (await canLaunch(url.toString())) {
                                        await launchUrl(
                                          url,
                                          mode: LaunchMode.externalApplication,
                                        );
                                      }
                                    },
                                    child: Text(
                                      widget.breed.wikipediaUrl!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF0000FF),
                                        decoration: TextDecoration.underline,
                                        decorationColor: Color(0xFF0000FF),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : buildInfoRow(
                                l10n.details_wikipedia,
                                widget.breed.wikipediaUrl,
                                isLast: true,
                              ),
                        SizedBox(height: 6),
                        // Sección: Características físicas
                        const CustomDivider(
                          thickness: 0.5,
                          margin: EdgeInsets.symmetric(vertical: 10),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.pets,
                              color: Color(0xFF6529CD),
                              size: 16,
                            ),
                            SizedBox(width: 6),
                            Text(
                              l10n.details_physical_characteristics,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6529CD),
                              ),
                            ),
                          ],
                        ),
                        const CustomDivider(
                          thickness: 0.5,
                          margin: EdgeInsets.symmetric(vertical: 10),
                        ),
                        // Esperanza de vida de la raza
                        buildInfoRow(
                          l10n.details_life_expectancy,
                          widget.breed.lifeSpan != null &&
                                  widget.breed.lifeSpan!.isNotEmpty
                              ? widget.breed.lifeSpan! + ' años'
                              : widget.breed.lifeSpan,
                        ),
                        // Peso de la raza
                        buildInfoRow(
                          l10n.details_weight,
                          widget.breed.weight != null &&
                                  widget.breed.weight!.isNotEmpty
                              ? widget.breed.weight! +
                                    ' ' +
                                    l10n.home_card_kilograms
                              : widget.breed.weight,
                        ),
                        // ¿La raza vive en interiores?
                        buildInfoRow(
                          l10n.details_indoor,
                          widget.breed.indoor == null
                              ? null
                              : (widget.breed.indoor! ? 'Sí' : 'No'),
                        ),
                        // Nivel de cepillado de la raza
                        buildStarsRow(
                          l10n.details_grooming,
                          widget.breed.grooming,
                        ),
                        // ¿La raza tiene problemas de salud?
                        buildStarsRow(
                          l10n.details_health_issues,
                          widget.breed.healthIssues,
                          isLast: true,
                        ),
                        SizedBox(height: 6),
                        // Sección: Personalidad y comportamiento
                        const CustomDivider(
                          thickness: 0.5,
                          margin: EdgeInsets.symmetric(vertical: 10),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.emoji_people,
                              color: Color(0xFF6529CD),
                              size: 16,
                            ),
                            SizedBox(width: 6),
                            Text(
                              l10n.details_personality_and_behavior,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6529CD),
                              ),
                            ),
                          ],
                        ),
                        const CustomDivider(
                          thickness: 0.5,
                          margin: EdgeInsets.symmetric(vertical: 10),
                        ),
                        // Temperamento de la raza
                        buildInfoRow(
                          l10n.details_temperament,
                          widget.breed.temperament,
                        ),
                        // Nivel de adaptabilidad de la raza
                        buildStarsRow(
                          l10n.details_adaptability,
                          widget.breed.adaptability,
                        ),
                        // ¿La raza es amigable con extraños?
                        buildStarsRow(
                          l10n.details_stranger_friendly,
                          widget.breed.strangerFriendly,
                        ),
                        // ¿La raza es amigable con niños?
                        buildStarsRow(
                          l10n.details_child_friendly,
                          widget.breed.childFriendly,
                        ),
                        // ¿La raza es amigable con perros?
                        buildStarsRow(
                          l10n.details_dog_friendly,
                          widget.breed.dogFriendly,
                        ),
                        // Nivel de inteligencia de la raza
                        buildStarsRow(
                          l10n.details_intelligence,
                          widget.breed.intelligence,
                        ),
                        // Nivel de afecto de la raza
                        buildStarsRow(
                          l10n.details_affection_level,
                          widget.breed.affectionLevel,
                        ),
                        // Nivel de energía de la raza
                        buildStarsRow(
                          l10n.details_energy_level,
                          widget.breed.energyLevel,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Footer generico de la aplicación
      bottomNavigationBar: CustomFooter(
        selectedIndex: 0,
        onItemTapped: (index) async {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              final result = await context.push('/favorites');
              if (result == 'refresh') {
                // Recargar favoritos para sincronizar el estado
                context.read<FavoritesCubit>().loadFavorites();
              }
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
