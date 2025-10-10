/*
 * @class FavoritesSqliteDatasource
 * @description Clase encargada de manejar la persistencia de la información de favoritos en la aplicación.
 * @autor Angela Andrade
 * @version 1.0 09/10/2025 Documentación y creación de la clase.
 */

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/favorite_cat_model.dart';

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
    * @param FavoriteCatModel cat - Modelo del gato a agregar.
    */
  Future<void> addFavorite(FavoriteCatModel cat) async {
    final db = await database;
    await db.insert(
      _tableName,
      cat.toMap(),
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
    * @return Future<List<FavoriteCatModel>> Lista de gatos favoritos.
    */
  Future<List<FavoriteCatModel>> getFavorites() async {
    final db = await database;
    final maps = await db.query(_tableName);
    return maps.map((map) => FavoriteCatModel.fromMap(map)).toList();
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
}
