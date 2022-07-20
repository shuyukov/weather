import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/model.dart';

class ApiDataProvider {
  Future getCurrentWeather(double lat, double lon) async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely,alerts&appid=ad31d354599c92d3653b5a1482d777ea&units=metric");
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    return AllWeather.fromJSON(body);
  }
}