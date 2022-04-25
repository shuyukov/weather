import 'package:weather/models/model.dart';
import 'package:weather/repositories/local.dart';
import 'package:weather/repositories/network.dart';

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
    final List<AllWeather> items = [];
    await Future.wait(result
        .map((e) => WeatherService().getWeatherByCityName(e.city).then((value) {
              if (value != null) {
                items.add(value);
              }
            }))
        .toList());
    return items;
  }

  Future<List<Cities>> getTipsList([String enteredCity = ""]) async {
    if (enteredCity.isEmpty) {
      return [];
    }
    final cities = await StorageRepository().getCitiesList();
    final matchedCityList = cities
        .where((element) =>
            element.city.toLowerCase().contains(enteredCity.toLowerCase()))
        .toList();
    return matchedCityList;
  }
}
