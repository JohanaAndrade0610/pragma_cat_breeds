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
    super.lifeSpan, // Esperanza de vida de la raza
    super.indoor, // ¿Vive en interiores?
    super.energyLevel, // Nivel de energía de la raza
    super.affectionLevel, // Nivel de afecto de la raza
    super.grooming, // Nivel de cepillado de la raza
    super.healthIssues, // Problemas de salud de la raza
    super.childFriendly, // ¿Es amigable con los niños?
    super.dogFriendly, // ¿Es amigable con los perros?
    super.strangerFriendly, // ¿Es amigable con los extraños?
    super.adaptability, // Nivel de adaptabilidad de la raza
    super.wikipediaUrl, // URL de Wikipedia
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
      lifeSpan: json['life_span'],
      indoor: json['indoor'] == null ? null : json['indoor'] == 1,
      energyLevel: json['energy_level'],
      affectionLevel: json['affection_level'],
      grooming: json['grooming'],
      healthIssues: json['health_issues'],
      childFriendly: json['child_friendly'],
      dogFriendly: json['dog_friendly'],
      strangerFriendly: json['stranger_friendly'],
      adaptability: json['adaptability'],
      wikipediaUrl: json['wikipedia_url'],
    );
  }
}
