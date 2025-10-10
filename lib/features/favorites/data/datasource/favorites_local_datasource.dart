/*
 * @class FavoritesLocalDatasource
 * @description Clase encargada de manejar la persistencia de la información de favoritos en la aplicación.
 * @autor Angela Andrade
 * @version 1.0 09/10/2025 Documentación y creación de la clase.
 */

import '../../../home/domain/entities/cat_breeds_entity.dart';

class FavoritesLocalDatasource {
  // Gatos favoritos almacenados
  final List<CatBreedsEntity> _favorites = [];
  // Método para obtener la lista de gatos favoritos
  List<CatBreedsEntity> getFavorites() => List.unmodifiable(_favorites);

  /*
    * @method addFavorite
    * @description Método encargado de agregar un gato a la lista de favoritos.
    * @param {CatBreedsEntity} cat - Gato a agregar a favoritos.
    */
  void addFavorite(CatBreedsEntity cat) {
    if (!_favorites.any((c) => c.id == cat.id)) {
      _favorites.add(cat);
    }
  }

  /*
    * @method removeFavorite
    * @description Método encargado de eliminar un gato de la lista de favoritos.
    * @param {String} id - ID del gato a eliminar de favoritos.
    */
  void removeFavorite(String id) {
    _favorites.removeWhere((c) => c.id == id);
  }

  /*
    * @method isFavorite
    * @description Método encargado de verificar si un gato está en la lista de favoritos.
    * @param {String} id - ID del gato a verificar.
    * @return {bool} - True si el gato está en favoritos, false en caso contrario.
    */
  bool isFavorite(String id) {
    return _favorites.any((c) => c.id == id);
  }
}
