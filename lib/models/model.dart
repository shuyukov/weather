// import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:intl/intl.dart';

class Model {
  double latitude;
  double longitude;
  int temperature;
  int wind;
  int humidity;
  int feelsLike;
  int pressure;
  String description;
  String icon;
  List<HourlyList> hourlyWeather;
  List<DailyList> dailyWeather;

  Model({
    required this.latitude,
    required this.longitude,
    required this.temperature,
    required this.wind,
    required this.humidity,
    required this.feelsLike,
    required this.pressure,
    required this.description,
    required this.icon,
    required this.hourlyWeather,
    required this.dailyWeather,
  });

  factory Model.fromJSON(Map<String, dynamic> json) {
    return Model(
      latitude: json["lat"],
      longitude: json["lon"],
      temperature: (json["current"]["temp"] as double).toInt(),
      wind: (json["current"]["wind_speed"] as double).toInt(),
      humidity: json["current"]["humidity"],
      feelsLike: (json["current"]["feels_like"] as double).toInt(),
      pressure: json["current"]["pressure"],
      description: json["current"]["weather"][0]["description"],
      icon: json["current"]["weather"][0]["icon"],
      hourlyWeather: (json["hourly"] as List<dynamic>).map((e) => HourlyList.fromJSON(e as Map<String, dynamic>)).toList(),
      dailyWeather: (json["daily"] as List<dynamic>).map((e) => DailyList.fromJSON(e as Map<String, dynamic>)).toList(),
    );
  }
}

class HourlyList {
  int hour;
  int temperature;
  String icon;

  HourlyList({
    required this.hour,
    required this.temperature,
    required this.icon,
  });

  factory HourlyList.fromJSON(Map<String, dynamic> json) {
    var hour = DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000).hour;
    return HourlyList(
      hour: hour,
      temperature: (json["temp"] as double).toInt(),
      icon: json["weather"][0]["icon"],
    );
  }
}

class DailyList {
  String day;
  String icon;
  int minTemp;
  int maxTemp;

  DailyList({
    required this.day,
    required this.icon,
    required this.minTemp,
    required this.maxTemp,
  });

  factory DailyList.fromJSON(Map<String, dynamic> json) {
    var date = DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000);
    var day = DateFormat('EEEE').format(date);
    return DailyList(
      day: day,
      icon: json["weather"][0]["icon"],
      minTemp: (json["temp"]["min"] as double).toInt(),
      maxTemp: (json["temp"]["max"] as double).toInt(),
      );
  }
}