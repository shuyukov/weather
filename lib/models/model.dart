// import 'package:freezed_annotation/freezed_annotation.dart';

class Model{
  double latitude;
  double longitude;
  int temperature;
  int wind;
  int humidity;
  int feelsLike;
  int pressure;

  Model({
    required this.latitude,
    required this.longitude,
    required this.temperature,
    required this.wind,
    required this.humidity,
    required this.feelsLike,
    required this.pressure
  });

  factory Model.fromJSON(Map<String, dynamic> json){
    return Model(
    latitude : json["lat"],
    longitude : json["lon"],
    temperature : (json["current"]["temp"] as double).toInt(),
    wind : (json["current"]["wind_speed"] as double).toInt(),
    humidity : json["current"]["humidity"],
    feelsLike : (json["current"]["feels_like"] as double).toInt(),
    pressure : json["current"]["pressure"],
    );
  }
}