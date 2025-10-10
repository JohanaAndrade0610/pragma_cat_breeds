/*
 * @class FavoritesSqliteDatasource
 * @description Clase encargada de manejar la persistencia de la información de favoritos en la aplicación.
 * @autor Angela Andrade
 * @version 1.0 09/10/2025 Documentación y creación de la clase.
 */

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../home/domain/entities/cat_breeds_entity.dart';

class FavoritesSqliteDatasource {
  // Nombre de la tabla en la base de datos
  static const String _tableName = 'favorites';
  // Instancia de la base de datos
  static Database? _db;

  /*
    * @method database
    * @description Getter para obtener la instancia de la base de datos, inicializándola si es necesario.
    * @return Future<Database> Instancia de la base de datos.
    */
  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  /*
    * @method _initDb
    * @description Método privado para inicializar la base de datos, creando la tabla si no existe.
    * @return Future<Database> Instancia de la base de datos.
    */
  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favorites.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            origin TEXT,
            imageUrl TEXT,
            wikipediaUrl TEXT,
            lifeSpan TEXT,
            weight TEXT,
            indoor INTEGER,
            grooming INTEGER,
            healthIssues INTEGER,
            temperament TEXT,
            adaptability INTEGER,
            strangerFriendly INTEGER,
            childFriendly INTEGER,
            dogFriendly INTEGER,
            intelligence INTEGER,
            affectionLevel INTEGER,
            energyLevel INTEGER
          )
        ''');
      },
    );
  }

  /*
    * @method addFavorite
    * @description Método para agregar un gato a la lista de favoritos.
    * @param CatBreedsEntity cat - Entidad del gato a agregar.
    */
  Future<void> addFavorite(CatBreedsEntity cat) async {
    final db = await database;
    await db.insert(
      _tableName,
      _toMap(cat),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /*
    * @method removeFavorite
    * @description Método para eliminar un gato de la lista de favoritos.
    * @param String id - ID del gato a eliminar.
    */
  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  /*
    * @method getFavorites
    * @description Método para obtener la lista de gatos favoritos.
    * @return Future<List<CatBreedsEntity>> Lista de gatos favoritos.
    */
  Future<List<CatBreedsEntity>> getFavorites() async {
    final db = await database;
    final maps = await db.query(_tableName);
    return maps.map((map) => _fromMap(map)).toList();
  }

  /*
    * @method isFavorite
    * @description Método para verificar si un gato está en la lista de favoritos.
    * @param String id - ID del gato a verificar.
    * @return Future<bool> True si el gato está en favoritos, false en caso contrario.
    */
  Future<bool> isFavorite(String id) async {
    final db = await database;
    final maps = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    return maps.isNotEmpty;
  }

  // Métodos privados para convertir entre CatBreedsEntity y Map<String, dynamic>
  Map<String, dynamic> _toMap(CatBreedsEntity cat) => {
    'id': cat.id,
    'name': cat.name,
    'description': cat.description,
    'origin': cat.origin,
    'imageUrl': cat.imageUrl,
    'wikipediaUrl': cat.wikipediaUrl,
    'lifeSpan': cat.lifeSpan,
    'weight': cat.weight,
    'indoor': cat.indoor == true ? 1 : 0,
    'grooming': cat.grooming,
    'healthIssues': cat.healthIssues,
    'temperament': cat.temperament,
    'adaptability': cat.adaptability,
    'strangerFriendly': cat.strangerFriendly,
    'childFriendly': cat.childFriendly,
    'dogFriendly': cat.dogFriendly,
    'intelligence': cat.intelligence,
    'affectionLevel': cat.affectionLevel,
    'energyLevel': cat.energyLevel,
  };

  // Convierte un Map<String, dynamic> a una instancia de CatBreedsEntity
  CatBreedsEntity _fromMap(Map<String, dynamic> map) => CatBreedsEntity(
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
}
