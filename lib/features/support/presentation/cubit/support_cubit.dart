/*
 * @class SupportCubit
 * @description Clase encargada de gestionar el estado de la ventana Support en la aplicación.
 * @autor Angela Andrade
 * @version 1.0 09/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit() : super(const SupportInitial());

  /*
  * @method load
  * @description Método encargado de cargar los datos iniciales para la ventana Support.
  */
  void load() {
    emit(const SupportLoaded());
  }
}
