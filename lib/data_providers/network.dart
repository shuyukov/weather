import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/model.dart';

class ApiDataProvider {
  Future<AllWeather> getCurrentWeather(double lat, double lon) async{
    var url = Uri.parse("https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely,alerts&appid=104c3c9c643553e181700efdd4608c25&units=metric");
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    return AllWeather.fromJSON(body);
  }
}