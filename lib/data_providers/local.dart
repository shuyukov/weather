import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:weather/models/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDataProvider {
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
    _database = await openDatabase(path, version: 1,
        onCreate: (Database database, int version) async {
      await database.execute(
          'create table if not exists $favCities ($columnId integer primary key autoincrement, $columnCity text not null, $columnLat double not null, $columnLon double not null)');
    });
    await getDataFromFile();
  }

  Future<List<Cities>> getDataFromFile() async {
    if (allCities.isEmpty) {
      final String response = await rootBundle.loadString('assets/cities.json');
      final data = await json.decode(response);
      allCities = Cities.listFromJson(data);
    }
    return allCities;
  }

  Future<List<Cities>> citiesLatLonDB() async {
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

  removeFavCity(String selectedCity) async {
    await _database.delete(favCities, where: '$columnCity = ?', whereArgs: [selectedCity]);
  }
}