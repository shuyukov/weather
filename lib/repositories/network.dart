import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/model.dart';

class WeaherAPI {
  Future<AllWeather> getCurrentWeather(double lat, double lon) async{
    var url = Uri.parse("https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely,alerts&appid=98e77dcccb0a976ca59c5493968f83c3&units=metric");
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    return AllWeather.fromJSON(body);
  }
}