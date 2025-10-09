/*
 * @class HomeRemoteDatasource
 * @description Clase encargada de manejar la obtención de datos remotos relacionados con las razas de gatos.
 * @author Angela Andrade
 * @version 1.0 08/10/2025 Creación y documentación de la clase.
 */

import '../models/cat_breeds_model.dart';
import 'package:dio/dio.dart';
import '../../../../core/config/app_config.dart';

class HomeRemoteDatasource {
  // Instancia de Dio para realizar solicitudes HTTP
  final Dio dio;
  // Clave de API para autenticación con el servicio remoto
  final String apiKey;

  HomeRemoteDatasource(this.dio, this.apiKey);

  /*
  * @method getCatBreeds
  * @description Método que obtiene una lista de razas de gatos desde un servicio remoto.
  * @returns Future<List<CatBreedsModel>> Una lista de modelos de razas de gatos.
  */
  Future<List<CatBreedsModel>> getCatBreeds() async {
    final response = await dio.get(
      AppConfig.catApiBaseUrl + 'breeds',
      options: Options(headers: {'x-api-key': apiKey}),
    );
    final data = response.data as List;
    return data.map((json) => CatBreedsModel.fromJson(json)).toList();
  }
}
