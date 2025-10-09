/*
 * @class CatBreedCard
 * @description Clase encargada de mostrar la tarjeta de una raza de gato.
 * @author Angela Andrade
 * @version 1.0 08/10/2025 Creación y documentación de la clase.
 */

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/cat_breeds_entity.dart';
import '../screens/cat_breed_detail_screen.dart';

class CatBreedCard extends StatelessWidget {
  // Entidad de la raza de gato a mostrar
  final CatBreedsEntity breed;
  // Texto de búsqueda para resaltar coincidencias
  final String searchText;
  const CatBreedCard({Key? key, required this.breed, this.searchText = ''})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Control de localización para multiples idiomas
    final l10n = AppLocalizations.of(context)!;
    // Resaltador del texto que coincide con la búsqueda
    Color highlightBg = Color(0xFF6529CD).withOpacity(0.25);

    // Resaltador de coincidencias en el texto
    InlineSpan highlightMatch(
      String text,
      String query,
      TextStyle? normalStyle,
    ) {
      if (query.isEmpty) return TextSpan(text: text, style: normalStyle);
      // Búsqueda sin distinción de mayúsculas/minúsculas
      final lowerText = text.toLowerCase();
      final lowerQuery = query.toLowerCase();
      // Lista de segmentos de texto
      List<InlineSpan> spans = [];
      // Índice de inicio para la búsqueda
      int start = 0;
      // Índice de la coincidencia encontrada
      int index;
      // Bucle para encontrar todas las coincidencias
      while ((index = lowerText.indexOf(lowerQuery, start)) != -1) {
        if (index > start) {
          spans.add(
            TextSpan(text: text.substring(start, index), style: normalStyle),
          );
        }
        spans.add(
          TextSpan(
            text: text.substring(index, index + query.length),
            style: (normalStyle ?? const TextStyle()).copyWith(
              backgroundColor: highlightBg,
            ),
          ),
        );
        start = index + query.length;
      }
      // Añadir el resto del texto que no coincide
      if (start < text.length) {
        spans.add(TextSpan(text: text.substring(start), style: normalStyle));
      }
      return TextSpan(children: spans);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      // Diseños de la tarjeta
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            // Sombra de la tarjeta
            BoxShadow(
              color: const Color(0xFF6529CD).withOpacity(0.25),
              blurRadius: 6,
              spreadRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Fotografia de la raza
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: ClipOval(
                    child: breed.imageUrl != null
                        ? Image.network(
                            breed.imageUrl!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => Container(
                              width: 120,
                              height: 120,
                              color: Colors.grey[200],
                              child: Icon(
                                Icons.pets,
                                size: 40,
                                color: Color(0xFF6529CD),
                              ),
                            ),
                          )
                        : Container(
                            width: 120,
                            height: 120,
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.pets,
                              size: 40,
                              color: Color(0xFF6529CD),
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 20),
                // Información de la raza
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Nombre de la raza
                      RichText(
                        text: highlightMatch(
                          breed.name,
                          searchText,
                          const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      // Origen de la raza
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: l10n.home_card_origin,
                              style: AppTheme.text11black87Semibold,
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: highlightMatch(
                                breed.origin ?? '-',
                                searchText,
                                AppTheme.text11black87Bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Peso de la raza
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: l10n.home_card_weight,
                              style: AppTheme.text11black87Semibold,
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: highlightMatch(
                                (breed.weight ?? '-') +
                                    ' ' +
                                    l10n.home_card_kilograms,
                                searchText,
                                AppTheme.text11black87Bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 9),
                      // Inteligencia de la raza
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: l10n.home_card_intelligence,
                              style: AppTheme.text11black87Semibold,
                            ),
                          ),
                          ...List.generate(5, (index) {
                            int intelligence = 0;
                            final value = breed.intelligence;
                            if (value != null) {
                              intelligence =
                                  int.tryParse(value.toString()) ?? 0;
                            }
                            return Icon(
                              index < intelligence
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Color(0xFF6529CD),
                              size: 14,
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 15),
                      // Botón para ver más información de la raza
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          // Navegación a la pantalla de detalles de la raza
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    CatBreedDetailScreen(breed: breed),
                              ),
                            );
                          },
                          // Diseño del botón
                          child: Row(
                            children: [
                              Icon(
                                Icons.remove_red_eye,
                                size: 14,
                                color: Color(0xFF6529CD),
                              ),
                              const SizedBox(width: 5),
                              Center(
                                child: Text(
                                  l10n.home_card_see_more_info,
                                  style: AppTheme.text146529CDSemibold.copyWith(
                                    color: Color(0xFF6529CD),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFF6529CD),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.visible,
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
