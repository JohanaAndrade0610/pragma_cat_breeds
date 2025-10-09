/*
 * @class Injection
 * @description Clase encargada de la inyección de dependencias en la aplicación.
 * @author Angela Andrade
 * @version 1.0 08/10/2025 Creación y documentación de la clase.
 */

import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../features/home/data/datasource/home_remote_datasource.dart';
import '../features/home/data/repositories/home_repository_impl.dart';
import '../features/home/domain/repositories/home_repository.dart';
import '../features/home/domain/usecases/get_cat_breeds_usecase.dart';
import '../features/home/presentation/cubit/home_cubit.dart';
import '../core/config/app_config.dart';

// Instancia de GetIt para la inyección de dependencias
final getIt = GetIt.instance;

void init() {
  // Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Fuente de datos remota
  getIt.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasource(getIt<Dio>(), AppConfig.catApiKey),
  );

  // Repositorio perteneciente a Inicio
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeRemoteDatasource>()),
  );

  // Caso de uso perteneciente a Inicio
  getIt.registerLazySingleton<GetCatBreedsUseCase>(
    () => GetCatBreedsUseCase(getIt<HomeRepository>()),
  );

  // Cubit perteneciente a Inicio
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getIt<GetCatBreedsUseCase>()),
  );
}
