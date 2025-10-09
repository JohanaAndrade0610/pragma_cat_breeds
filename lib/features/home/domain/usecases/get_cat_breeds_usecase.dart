/*
 * @class GetCatBreedsUseCase
 * @description Clase encargada de definir el caso de uso para obtener las razas de gatos.
 * @author Angela Andrade
 * @version 1.0 08/10/2025 Creación y documentación de la clase.
 */

import '../entities/cat_breeds_entity.dart';
import '../repositories/home_repository.dart';

class GetCatBreedsUseCase {
  // Repositorio para acceder a los datos
  final HomeRepository repository;
  GetCatBreedsUseCase(this.repository);

  /*
  * @method call
  * @description Método que ejecuta el caso de uso para obtener una lista de razas de gatos.
  * @returns Future<List<CatBreedsEntity>> Una lista de entidades de razas de gatos.
  */
  Future<List<CatBreedsEntity>> call() async {
    return await repository.getCatBreeds();
  }
}
