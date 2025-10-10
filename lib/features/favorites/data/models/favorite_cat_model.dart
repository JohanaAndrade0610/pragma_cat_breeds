/*
 * @class FavoriteCatModel
 * @description Clase encargada de representar un gato favorito.
 * @autor Angela Andrade
 * @version 1.0 09/10/2025 Documentación y creación de la clase.
 */

import '../../../home/domain/entities/cat_breeds_entity.dart';

class FavoriteCatModel {
  final String id; // ID de la raza
  final String name; // Nombre de la raza
  final String description; // Descripción de la raza
  final String origin; // Origen de la raza
  final String imageUrl; // Imagen de la raza
  final String wikipediaUrl; // URL de wikipedia
  final String lifeSpan; // Esperanza de vida de la raza
  final String weight; // Peso de la raza
  final bool indoor; // ¿La raza es de interior?
  final int grooming; // Nivel de cepillado de la raza
  final int healthIssues; // Problemas de salud de la raza
  final String temperament; // Temperamento de la raza
  final int adaptability; // Adaptabilidad de la raza
  final int strangerFriendly; // Amigable con extraños
  final int childFriendly; // Amigable con niños
  final int dogFriendly; // Amigable con perros
  final int intelligence; // Nivel de inteligencia de la raza
  final int affectionLevel; // Nivel de afecto de la raza
  final int energyLevel; // Nivel de energía de la raza

  FavoriteCatModel({
    required this.id,
    required this.name,
    required this.description,
    required this.origin,
    required this.imageUrl,
    required this.wikipediaUrl,
    required this.lifeSpan,
    required this.weight,
    required this.indoor,
    required this.grooming,
    required this.healthIssues,
    required this.temperament,
    required this.adaptability,
    required this.strangerFriendly,
    required this.childFriendly,
    required this.dogFriendly,
    required this.intelligence,
    required this.affectionLevel,
    required this.energyLevel,
  });

  // Mapeo desde y hacia Map para persistencia en SQLite
  factory FavoriteCatModel.fromMap(Map<String, dynamic> map) =>
      FavoriteCatModel(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        origin: map['origin'],
        imageUrl: map['imageUrl'],
        wikipediaUrl: map['wikipediaUrl'],
        lifeSpan: map['lifeSpan'],
        weight: map['weight'],
        indoor: map['indoor'] == 1,
        grooming: map['grooming'],
        healthIssues: map['healthIssues'],
        temperament: map['temperament'],
        adaptability: map['adaptability'],
        strangerFriendly: map['strangerFriendly'],
        childFriendly: map['childFriendly'],
        dogFriendly: map['dogFriendly'],
        intelligence: map['intelligence'],
        affectionLevel: map['affectionLevel'],
        energyLevel: map['energyLevel'],
      );

  // Convierte a Map para almacenamiento en SQLite
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'origin': origin,
    'imageUrl': imageUrl,
    'wikipediaUrl': wikipediaUrl,
    'lifeSpan': lifeSpan,
    'weight': weight,
    'indoor': indoor ? 1 : 0,
    'grooming': grooming,
    'healthIssues': healthIssues,
    'temperament': temperament,
    'adaptability': adaptability,
    'strangerFriendly': strangerFriendly,
    'childFriendly': childFriendly,
    'dogFriendly': dogFriendly,
    'intelligence': intelligence,
    'affectionLevel': affectionLevel,
    'energyLevel': energyLevel,
  };

  // Convierte desde CatBreedsEntity a FavoriteCatModel
  factory FavoriteCatModel.fromEntity(CatBreedsEntity entity) {
    return FavoriteCatModel(
      id: entity.id,
      name: entity.name,
      description: entity.description ?? '',
      origin: entity.origin ?? '',
      imageUrl: entity.imageUrl ?? '',
      wikipediaUrl: entity.wikipediaUrl ?? '',
      lifeSpan: entity.lifeSpan ?? '',
      weight: entity.weight ?? '',
      indoor: entity.indoor ?? false,
      grooming: entity.grooming ?? 0,
      healthIssues: entity.healthIssues ?? 0,
      temperament: entity.temperament ?? '',
      adaptability: entity.adaptability ?? 0,
      strangerFriendly: entity.strangerFriendly ?? 0,
      childFriendly: entity.childFriendly ?? 0,
      dogFriendly: entity.dogFriendly ?? 0,
      intelligence: entity.intelligence ?? 0,
      affectionLevel: entity.affectionLevel ?? 0,
      energyLevel: entity.energyLevel ?? 0,
    );
  }

  // Convierte desde FavoriteCatModel a CatBreedsEntity
  CatBreedsEntity toEntity() {
    return CatBreedsEntity(
      id: id,
      name: name,
      description: description.isEmpty ? null : description,
      origin: origin.isEmpty ? null : origin,
      imageUrl: imageUrl.isEmpty ? null : imageUrl,
      wikipediaUrl: wikipediaUrl.isEmpty ? null : wikipediaUrl,
      lifeSpan: lifeSpan.isEmpty ? null : lifeSpan,
      weight: weight.isEmpty ? null : weight,
      indoor: indoor,
      grooming: grooming == 0 ? null : grooming,
      healthIssues: healthIssues == 0 ? null : healthIssues,
      temperament: temperament.isEmpty ? null : temperament,
      adaptability: adaptability == 0 ? null : adaptability,
      strangerFriendly: strangerFriendly == 0 ? null : strangerFriendly,
      childFriendly: childFriendly == 0 ? null : childFriendly,
      dogFriendly: dogFriendly == 0 ? null : dogFriendly,
      intelligence: intelligence == 0 ? null : intelligence,
      affectionLevel: affectionLevel == 0 ? null : affectionLevel,
      energyLevel: energyLevel == 0 ? null : energyLevel,
    );
  }
}
