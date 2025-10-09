/*
 * @class HomeRepositoryImpl
 * @description Clase encargada de implementar el repositorio de la ventana Inicio
 * @author Angela Andrade
 * @version 1.0 08/10/2025 Creación y documentación de la clase.
 */

import '../../domain/entities/cat_breeds_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasource/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  // Fuente de datos remota
  final HomeRemoteDatasource remoteDatasource;
  HomeRepositoryImpl(this.remoteDatasource);

  /*
  * @method getCatBreeds
  * @description Método que obtiene una lista de razas de gatos desde la fuente de datos remota.
  * @returns Future<List<CatBreedsEntity>> Una lista de entidades de razas de gatos.
  */
  @override
  Future<List<CatBreedsEntity>> getCatBreeds() async {
    return await remoteDatasource.getCatBreeds();
  }
}
