/*
 * @class FavoritesRepository
 * @description Repositorio abstracto para manejar las operaciones relacionadas con los gatos favoritos.
 * @autor Angela Andrade
 * @version 1.0 09/10/2025 Documentación y creación de la clase.
 */

import '../../../home/domain/entities/cat_breeds_entity.dart';

abstract class FavoritesRepository {
  /*
    * @method getFavorites
    * @description Obtiene la lista de gatos favoritos.
    */
  Future<List<CatBreedsEntity>> getFavorites();

  /*
    * @method addFavorite
    * @description Agrega un gato a la lista de favoritos.
    */
  Future<void> addFavorite(CatBreedsEntity cat);

  /*
    * @method removeFavorite
    * @description Elimina un gato de la lista de favoritos.
    */
  Future<void> removeFavorite(String id);

  /*
    * @method isFavorite
    * @description Verifica si un gato es favorito.
    */
  Future<bool> isFavorite(String id);
}
