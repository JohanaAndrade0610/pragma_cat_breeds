/*
 * @class FavoritesRepositoryImpl
 * @description Clase encargada de contener la implementación del repositorio de favoritos.
 * @autor Angela Andrade
 * @version 1.0 09/10/2025 Documentación y creación de la clase.
 */

import '../../domain/repositories/favorites_repository.dart';
import '../../../home/domain/entities/cat_breeds_entity.dart';
import '../datasource/favorites_sqlite_datasource.dart';
import '../models/favorite_cat_model.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  // Base de datos local SQLite
  final FavoritesSqliteDatasource datasource;

  FavoritesRepositoryImpl(this.datasource);

  /*
* @method getFavorites
 * @description Método encargado de obtener la lista de gatos favoritos desde la base de datos local SQLite
 * @return Future<List<CatBreedsEntity>> Lista de gatos favoritos.
*/
  @override
  Future<List<CatBreedsEntity>> getFavorites() async {
    final favoriteModels = await datasource.getFavorites();
    return favoriteModels.map((model) => model.toEntity()).toList();
  }

  /*
* @method addFavorite
 * @description Método encargado de agregar un gato a la lista de favoritos en la base de datos local SQLite
 * @param CatBreedsEntity cat - Entidad del gato a agregar.
*/
  @override
  Future<void> addFavorite(CatBreedsEntity cat) async {
    final favoriteModel = FavoriteCatModel.fromEntity(cat);
    await datasource.addFavorite(favoriteModel);
  }

  /*
* @method removeFavorite
 * @description Método encargado de eliminar un gato de la lista de favoritos en la base de datos local SQLite
*/
  @override
  Future<void> removeFavorite(String id) => datasource.removeFavorite(id);

  /*
* @method isFavorite
 * @description Método encargado de verificar si un gato está en la lista de favoritos en la base de datos local SQLite
*/
  @override
  Future<bool> isFavorite(String id) => datasource.isFavorite(id);
}
