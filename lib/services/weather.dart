import 'package:weather/models/model.dart';
import 'package:weather/repositories/local.dart';
import 'package:weather/repositories/network.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherService {
  Future<AllWeather?> getWeatherByCityName(String enteredCity) async {
    final cities = await StorageRepository().getCitiesList();
    final enteredCityList = cities
        .where((element) =>
            element.city.toLowerCase() == enteredCity.toLowerCase())
        .toList();
    if (enteredCityList.isEmpty) {
      return null;
    }
    final currentCity = enteredCityList[0];
    final weatherByCityName =
        await WeaherAPI().getCurrentWeather(currentCity.lat, currentCity.lon);
    weatherByCityName.name = currentCity.city;
    return weatherByCityName;
  }

  Future<List<AllWeather>> getFavWeatherList() async {
    final result = await StorageRepository().readFavCities();
    return await Future.wait(result
        .map((e) => getWeatherByCityName(e.city).then((value)=>value!))
        .toList());
  }

  Future<List<Cities>> getHintList([String enteredCity = ""]) async {
    if (enteredCity.isEmpty || enteredCity.length <=2) {
      return [];
    }
    final cities = await StorageRepository().getCitiesList();
    final matchedCityList = cities
        .where((element) =>
            element.city.toLowerCase().contains(enteredCity.toLowerCase()))
        .toList();
    final uniqueCities = matchedCityList.map((e) => e.city).toSet();
    matchedCityList.retainWhere((e) => uniqueCities.remove(e.city));
    return matchedCityList;
  }

}
