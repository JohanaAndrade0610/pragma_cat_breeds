/*
 * @class CatBreedsModel
 * @description Clase encargada de representar el modelo de datos de las razas de gatos, extendiendo la entidad CatBreedsEntity.
 * @author Angela Andrade
 * @version 1.0 08/10/2025 Creación y documentación de la clase.
 */

import '../../domain/entities/cat_breeds_entity.dart';

class CatBreedsModel extends CatBreedsEntity {
  CatBreedsModel({
    required super.id, // Id de la raza
    required super.name, // Nombre de la raza
    super.description, // Descripción de la raza
    super.temperament, // Temperamento de la raza
    super.origin, // Origen de la raza
    super.imageUrl, // URL de la imagen de la raza
    super.weight, // Peso de la raza
    super.intelligence, // Nivel de inteligencia de la raza
  });

  factory CatBreedsModel.fromJson(Map<String, dynamic> json) {
    return CatBreedsModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      temperament: json['temperament'],
      origin: json['origin'],
      imageUrl: json['image'] != null ? json['image']['url'] : null,
      weight: json['weight'] != null ? json['weight']['metric'] : null,
      intelligence: json['intelligence'],
    );
  }
}
