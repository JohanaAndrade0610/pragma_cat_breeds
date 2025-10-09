/*
 * @class CatBreedsEntity
 * @description Clase encargada de representar la entidadde datos de las razas de gatos.
 * @author Angela Andrade
 * @version 1.0 08/10/2025 Creación y documentación de la clase.
 */

class CatBreedsEntity {
  final String id; // Id de la raza
  final String name; // Nombre de la raza
  final String? description; // Descripción de la raza
  final String? temperament; // Temperamento de la raza
  final String? origin; // Origen de la raza
  final String? imageUrl; // URL de la imagen de la raza
  final String? weight; // Peso de la raza
  final int? intelligence; // Nivel de inteligencia de la raza
  final String? lifeSpan; // Esperanza de vida de la raza
  final bool? indoor; // ¿Vive en interiores?
  final int? energyLevel; // Nivel de energía de la raza
  final int? affectionLevel; // Nivel de afecto de la raza
  final int? grooming; // Nivel de cepillado de la raza
  final int? healthIssues; // Problemas de salud de la raza
  final int? childFriendly; // ¿Es amigable con los niños?
  final int? dogFriendly; // ¿Es amigable con los perros?
  final int? strangerFriendly; // ¿Es amigable con los extraños?
  final int? adaptability; // Nivel de adaptabilidad de la raza
  final String? wikipediaUrl; // URL de Wikipedia de la raza

  CatBreedsEntity({
    required this.id,
    required this.name,
    this.description,
    this.temperament,
    this.origin,
    this.imageUrl,
    this.weight,
    this.intelligence,
    this.lifeSpan,
    this.indoor,
    this.energyLevel,
    this.affectionLevel,
    this.grooming,
    this.healthIssues,
    this.childFriendly,
    this.dogFriendly,
    this.strangerFriendly,
    this.adaptability,
    this.wikipediaUrl,
  });
}
