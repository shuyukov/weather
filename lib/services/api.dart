import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/model.dart';

class Api {
  Future<Model> getCurrentWeather(double latitude, double longitude) async{
    var endpoint = Uri.parse("https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=minutely,alerts&appid=98e77dcccb0a976ca59c5493968f83c3&units=metric");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    return Model.fromJSON(body);
  }
}