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

  CatBreedsEntity({
    required this.id,
    required this.name,
    this.description,
    this.temperament,
    this.origin,
    this.imageUrl,
    this.weight,
    this.intelligence,
  });
}
