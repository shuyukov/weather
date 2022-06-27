import 'package:weather/data_providers/network.dart';
import 'package:weather/models/model.dart';
import 'package:weather/repositories/local.dart';

class LocalDataProvider {
  final LocalRepositories _localRepositories;
  LocalDataProvider(this._localRepositories);

  Future<AllWeather?> getWeatherByCity(String enteredCity) async {
    final cities = await _localRepositories.getListOfAllCities();
    final enteredCityList = cities
        .where((e) =>
            e.city.toLowerCase() == enteredCity.toLowerCase())
        .toList();
    if (enteredCityList.isEmpty) {
      return null;
    }
    final currentCity = enteredCityList[0];
    final weatherByCity =
        await ApiDataProvider().getCurrentWeather(currentCity.lat, currentCity.lon);
    weatherByCity.city = currentCity.city;
    return weatherByCity;
  }

  Future<List<AllWeather>> getFavWeatherList() async {
    final result = await _localRepositories.getFavCitiesList();
    return await Future.wait(result
        .map((e) => getWeatherByCity(e.city).then((value)=>value!))
        .toList());
  }

  Future<List<Cities>> getHintList([String enteredCity = ""]) async {
    if (enteredCity.isEmpty || enteredCity.length <=2) {
      return [];
    }
    final cities = await _localRepositories.getListOfAllCities();
    final matchedCityList = cities
        .where((element) =>
            element.city.toLowerCase().contains(enteredCity.toLowerCase()))
        .toList();
    final uniqueCities = matchedCityList.map((e) => e.city).toSet();
    matchedCityList.retainWhere((e) => uniqueCities.remove(e.city));
    return matchedCityList;
  }

}
