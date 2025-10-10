/*
 * @class FavoritesCubit
 * @description Clase encargada de manejar el estado de la ventana de favoritos
 * @autor Angela Andrade
 * @version 1.0 09/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/domain/entities/cat_breeds_entity.dart';
import '../../domain/repositories/favorites_repository.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  // Repositorio de favoritos
  final FavoritesRepository repository;

  FavoritesCubit(this.repository) : super(FavoritesInitial()) {
    loadFavorites();
  }

  /*
    * @method loadFavorites
    * @description Carga la lista de gatos favoritos desde el repositorio y emite el estado correspondiente.
    */
  Future<void> loadFavorites() async {
    emit(FavoritesInitial());
    final favorites = await repository.getFavorites();
    emit(FavoritesLoaded(favorites));
  }

  /*
    * @method toggleFavorite
    * @description Agrega o elimina un gato de la lista de favoritos y actualiza el estado.
    */
  Future<void> toggleFavorite(CatBreedsEntity cat) async {
    final isFav = await repository.isFavorite(cat.id);
    if (isFav) {
      await repository.removeFavorite(cat.id);
    } else {
      await repository.addFavorite(cat);
    }
    final favorites = await repository.getFavorites();
    emit(FavoritesLoaded(favorites));
  }

  /*
    * @method isFavorite
    * @description Verifica si un gato es favorito.
    */
  Future<bool> isFavorite(String id) async => repository.isFavorite(id);
}
