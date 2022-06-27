import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:weather/models/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalRepositories {
  late final Database _database;

  List<Cities> allCities = [];
  List<Cities> listFromTable = [];

  final String favCities = 'favCities';
  final String columnId = '_id';
  final String columnCity = 'city';
  final String columnLat = 'lat';
  final String columnLon = 'lon';

  Future init() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "favCities.db");
    print("database's path: $path");
    _database = await openDatabase(path, version: 1,
        onCreate: (Database database, int version) async {
      await database.execute(
          'create table if not exists $favCities ($columnId integer primary key autoincrement, $columnCity text not null, $columnLat double not null, $columnLon double not null)');
    });
    print("database has been created");
    getListOfAllCities();
  }

  Future<List<Cities>> getListOfAllCities() async {
    if (allCities.isEmpty) {
      final String response = await rootBundle.loadString('assets/cities.json');
      final data = await json.decode(response);
      allCities = Cities.listFromBody(data);
      print("list from json has been created");
    }

    return allCities;
  }

  Future<List<Cities>> getFavCitiesList() async {
    final favCitiesList = (await _database.rawQuery('SELECT * FROM $favCities'))
        .map((e) => Cities.fromDB(e))
        .toList();
    return favCitiesList;
  }

  saveFavCity(Cities item) async {
    await _database.rawInsert(
        'INSERT INTO $favCities ($columnCity, $columnLat, $columnLon) VALUES(?, ?, ?)',
        [item.city, item.lat, item.lon]);
  }

  delFavCity(Cities item) {
    _database
        .rawDelete('DELETE FROM $favCities WHERE $columnCity = ?', [item.city]);
  }
}