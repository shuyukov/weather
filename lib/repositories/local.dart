import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:weather/models/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class StorageRepository {
  late final Database _database;

  List<Cities> allCities = [];
  List<Cities> listFromTable = [];

  Future init() async {
    await _openDB();
    await getCitiesList();
  }

  Future _openDB() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "cities.db");

    _database = await openDatabase(path, version: 1,
        onCreate: (Database database, int version) async {
      await database.execute(
          'CREATE TABLE CitiesTable (id INTEGER PRIMARY KEY, city TEXT, lat DOUBLE, lon DOUBLE, isFav INTEGER)');
    }); 
  }

  Future<List<Cities>> getCitiesList() async {
    if (allCities.isEmpty) {
      final String response = await rootBundle.loadString('assets/cities.json');
      final data = await json.decode(response);
      allCities = Cities.listFromBody(data);

      await _database.transaction((txn) async {
        allCities.map((e) => txn.rawInsert(
            'INSERT INTO CitiesTable (city, lat, lon, isFav) VALUES(${e.city}, ${e.lat}, ${e.lon}, 0)'));
      });
      _database.close();
    }
    return [];
  }

  Future saveFavCities(List<Cities> items) async {
    await _openDB();
    items.map((e) => _database
        .rawUpdate('UPDATE CitiesList SET isFav = 1 WHERE city = ${e.city}'));
    _database.close();
  }

  Future<List<Cities>> readFavCities() async {
    await _openDB();
    final favCities =
        (await _database.rawQuery('SELECT * FROM CitiesTable WHERE isFav = 1'))
            .map((e) => Cities.fromDB(e))
            .toList();
    _database.close();
    return favCities;
  }
}
