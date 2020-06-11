
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tabela_fipe_flutter/models/favoriteModel.dart';

class FavoriteDatabaseService {
  FavoriteDatabaseService._();

  static final FavoriteDatabaseService db = FavoriteDatabaseService._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstace();
    return _database;
  }

  Future<Database> getDatabaseInstace() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "FIPEfav.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE Favorites ("
          "id integer primary key AUTOINCREMENT,"
          "name TEXT,"
          "price TEXT,"
          "url TEXT"
          ")"
        );
    });
  }

  addFavorite(FavoriteModel favorite) async {
    final db = await database;
    var raw = await db.insert(
      'Favorites',
      favorite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateFavorite(FavoriteModel favorite) async {
    final db = await database;
    var response = await db.update('Favorites', favorite.toMap(),
        where: 'id = ?', whereArgs: [favorite.id]);
    return response;
  }

  Future<FavoriteModel> getFavoriteWithId(int id) async {
    final db = await database;
    var response = await db.query('Favorites', where: 'id = ?', whereArgs: [id]);
    return response.isNotEmpty ? FavoriteModel.fromMap(response.first) : null;
  }

  Future<List<FavoriteModel>> getAllFavorites() async {
    final db = await database;
    var response = await db.query("Favorites");
    List<FavoriteModel> list = response.map((c) => FavoriteModel.fromMap(c)).toList();
    return list;
  }

  deleteFavoriteWithId(int id) async {
    final db = await database;
    return db.delete("Favorites", where: "id = ?", whereArgs: [id]);
  }

  deleteAllFavorites() async {
    final db = await database;
    db.delete("Favorites");
  }

}