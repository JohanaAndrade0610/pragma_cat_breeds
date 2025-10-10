/*
 * @class FavoritesState
 * @description Estado de la ventana de favoritos.
 * @autor Angela Andrade
 * @version 1.0 09/10/2025 Documentación y creación de la clase.
 */

import '../../../home/domain/entities/cat_breeds_entity.dart';

abstract class FavoritesState {}

/*
  * @class FavoritesInitial
  * @description Estado inicial de la ventana de favoritos.
  */
class FavoritesInitial extends FavoritesState {}

/*
  * @class FavoritesLoaded
  * @description Estado cuando se han cargado los gatos favoritos.
  */
class FavoritesLoaded extends FavoritesState {
  final List<CatBreedsEntity> favorites;
  FavoritesLoaded(this.favorites);
}
