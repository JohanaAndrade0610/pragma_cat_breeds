/*
 * @class FavoriteCatEntity
 * @description Clase encargada de representar un gato favorito.
 * @autor Angela Andrade
 * @version 1.0 09/10/2025 Documentación y creación de la clase.
 */

import '../../../home/domain/entities/cat_breeds_entity.dart';

class FavoriteCatEntity extends CatBreedsEntity {
  FavoriteCatEntity({
    required super.id, // ID de la raza
    required super.name, // Nombre de la raza
    super.description, // Descripción de la raza
    super.origin, // Origen de la raza
    super.imageUrl, // Imagen de la raza
    super.wikipediaUrl, // URL de Wikipedia de la raza
    super.lifeSpan, // Esperanza de vida de la raza
    super.weight, // Peso de la raza
    super.indoor, // ¿La raza vive en interiores?
    super.grooming, // Nivel de capillado de la raza
    super.healthIssues, // Nivel de problemas de salud de la raza
    super.temperament, // Temperamento de la raza
    super.adaptability, // Adaptabilidad de la raza
    super.strangerFriendly, // Nivel de amabilidad con extraños de la raza
    super.childFriendly, // Nivel de amabilidad con niños de la raza
    super.dogFriendly, // Nivel de amabilidad con perros de la raza
    super.intelligence, // Inteligencia de la raza
    super.affectionLevel, // Nivel de afecto de la raza
    super.energyLevel, // Nivel de energía de la raza
  });
}
