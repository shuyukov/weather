import 'package:weather/data_providers/local.dart';
import 'package:weather/data_providers/network.dart';
import 'package:weather/models/model.dart';

class CitiesRepository {
  CitiesRepository(this._localDataProvider, this._apiDataProvider);

  final LocalDataProvider _localDataProvider;
  final ApiDataProvider _apiDataProvider;

  Future init() async {
    await _localDataProvider.init();
  }

  Future saveFavCity(Cities item) async {
    await _localDataProvider.saveFavCity(item);
  }

  Future removeFavCity(String selectedCity) async {
    await _localDataProvider.removeFavCity(selectedCity);
  }

  Future<List<AllWeather>> checkAndSaveCity(String enteredCity) async {
    final result = await getWeatherByCity(enteredCity);
    final citiesList = await getWeatherForFavCities();
    if (result != null &&
        citiesList.where((e) => e.city == result.city).isEmpty) {
      citiesList.add(result);
      saveFavCity(Cities.fromWeather(result));
    }
    return citiesList;
  }

  Future<List<AllWeather>> getWeatherForFavCities() async {
    final result = await _localDataProvider.getFavCitiesList();
    return await Future.wait(result
        .map((e) => getWeatherByCity(e.city).then((value) => value!))
        .toList());
  }

  Future<AllWeather?> getWeatherByCity(String city) async {
    final cities = await _localDataProvider.getListOfAllCities();
    final enteredCityList = cities
        .where((e) => e.city.toLowerCase() == city.toLowerCase())
        .toList();
    if (enteredCityList.isEmpty) {
      return null;
    }
    final currentCity = enteredCityList[0];
    final weatherByCity = await _apiDataProvider.getCurrentWeather(
        currentCity.lat, currentCity.lon);
    weatherByCity.city = currentCity.city;
    return weatherByCity;
  }

  Future<List<Cities>> getListOfHints([String enteredText = ""]) async {
    if (enteredText.isEmpty || enteredText.length <= 2) {
      return [];
    }
    final cities = await _localDataProvider.getListOfAllCities();
    final matchedCityList = cities
        .where((element) =>
            element.city.toLowerCase().contains(enteredText.toLowerCase()))
        .toList();
    final uniqueCities = matchedCityList.map((e) => e.city).toSet();
    matchedCityList.retainWhere((e) => uniqueCities.remove(e.city));
    return matchedCityList;
  }
}
