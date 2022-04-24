import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/model.dart';

class StorageRepository {
  static List<Cities> allCities = [];

  Future<List<Cities>> getCitiesList() async {
    if (allCities.isEmpty) {
      final String response = await rootBundle.loadString('assets/cities.json');
      final data = await json.decode(response);
      allCities = Cities.listFromBody(data);
    }
    return allCities;
  }

  Future saveFavCities(List<Cities> items) async {
    final responce = Cities.jsonFromList(items);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('favCities', responce);
  }

  Future<List<Cities>> readFavCities() async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getString('favCities') ?? "[]";
    final data = await json.decode(items);
    return Cities.listFromBody(data);
  }
}
