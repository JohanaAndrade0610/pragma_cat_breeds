/*
 * @class HomeState
 * @description Clase encargada de definir el estado de la pantalla de inicio.
 * @author Angela Andrade
 * @version 1.0 08/10/2025 Creación y documentación de la clase.
 */

part of 'home_cubit.dart';

abstract class HomeState {}

// Estado inicial
class HomeInitial extends HomeState {}

// Estado de carga
class HomeLoading extends HomeState {}

// Estado cargado con éxito
class HomeLoaded extends HomeState {
  final List<dynamic> breeds;
  HomeLoaded(this.breeds);
}

// Estado de error
class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
