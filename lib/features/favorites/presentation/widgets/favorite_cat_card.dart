/*
 * @class FavoriteCatCard
 * @description Clase encargada de mostrar las tarjetas de gatos favoritos.
 * @autor Angela Andrade
 * @version 1.0 10/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/domain/entities/cat_breeds_entity.dart';
import '../cubit/favorites_cubit.dart';

class FavoriteCatCard extends StatelessWidget {
  // Entidad del gato favorito
  final CatBreedsEntity cat;

  const FavoriteCatCard({required this.cat, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoritesCubit>();
    // Diseño del card
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
          //Nombre del gato e icono de favorito
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
                  child: const Icon(
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
