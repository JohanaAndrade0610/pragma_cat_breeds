/*
 * @class HomeCubit
 * @description Clase encargada de gestionar el estado de la pantalla de inicio.
 * @author Angela Andrade
 * @version 1.0 08/10/2025 Creación y documentación de la clase.
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_cat_breeds_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  // Caso de uso para obtener las razas de gatos
  final GetCatBreedsUseCase getCatBreedsUseCase;
  HomeCubit(this.getCatBreedsUseCase) : super(HomeInitial());

  /*
  * @method loadCatBreeds
  * @description Método que carga las razas de gatos y actualiza el estado en consecuencia.
  */
  Future<void> loadCatBreeds() async {
    emit(HomeLoading());
    try {
      final breeds = await getCatBreedsUseCase();
      emit(HomeLoaded(breeds));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
