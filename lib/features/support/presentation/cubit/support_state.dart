/*
 * @class SupportState
 * @description Clase encargada de definir los estados de la ventana Support en la aplicación.
 * @autor Angela Andrade
 * @version 1.0 09/10/2025 Documentación y creación de la clase.
 */

import 'package:equatable/equatable.dart';

abstract class SupportState extends Equatable {
  const SupportState();
  @override
  List<Object?> get props => [];
}

/*
  * @class SupportInitial
  * @description Estado inicial de la ventana Support.
  */
class SupportInitial extends SupportState {
  const SupportInitial();
}

/*
  * @class SupportLoaded
  * @description Estado cuando los datos de la ventana Support han sido cargados.
  */
class SupportLoaded extends SupportState {
  const SupportLoaded();
}
