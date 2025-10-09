/*
 * @class HomeRepository
 * @description Clase encargada de definir el contrato para la obtención de datos relacionados con las razas de gatos.
 * @author Angela Andrade
 * @version 1.0 08/10/2025 Creación y documentación de la clase.
 */

import '../entities/cat_breeds_entity.dart';

abstract class HomeRepository {
  // Método para obtener una lista de razas de gatos
  Future<List<CatBreedsEntity>> getCatBreeds();
}
