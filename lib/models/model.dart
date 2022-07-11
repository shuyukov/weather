import 'dart:convert';
import 'package:intl/intl.dart';

class AllWeather {
  String city = "";
  double lat;
  double lon;
  int temp;
  int wind;
  int humidity;
  int feelsLike;
  int pressure;
  String description;
  String icon;
  List<HourlyList> hourlyWeather;
  List<DailyList> dailyWeather;

  AllWeather({
    required this.lat,
    required this.lon,
    required this.temp,
    required this.wind,
    required this.humidity,
    required this.feelsLike,
    required this.pressure,
    required this.description,
    required this.icon,
    required this.hourlyWeather,
    required this.dailyWeather,
  });

  factory AllWeather.fromJSON(Map<String, dynamic> json) {
    return AllWeather(
      lat: json["lat"],
      lon: json["lon"],
      temp: json["current"]["temp"].toInt(),
      wind: (json["current"]["wind_speed"]).toInt(),
      humidity: json["current"]["humidity"],
      feelsLike: json["current"]["feels_like"].toInt(),
      pressure: json["current"]["pressure"],
      description: json["current"]["weather"][0]["description"],
      icon: json["current"]["weather"][0]["icon"],
      hourlyWeather: (json["hourly"] as List<dynamic>)
          .map((e) => HourlyList.fromJSON(
              e as Map<String, dynamic>, json["timezone_offset"]))
          .toList(),
      dailyWeather: (json["daily"] as List<dynamic>)
          .map((e) => DailyList.fromJSON(
              e as Map<String, dynamic>, json["timezone_offset"]))
          .toList(),
    );
  }
}

class HourlyList {
  int hour;
  int temp;
  String icon;

  HourlyList({
    required this.hour,
    required this.temp,
    required this.icon,
  });

  factory HourlyList.fromJSON(Map<String, dynamic> json, int timezoneOffset) {
    var hour = DateTime.fromMillisecondsSinceEpoch(
            (json["dt"] + timezoneOffset) * 1000)
        .hour;
    return HourlyList(
      hour: hour,
      temp: json["temp"].toInt(),
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

  factory DailyList.fromJSON(Map<String, dynamic> json, int timezoneOffset) {
    var date = DateTime.fromMillisecondsSinceEpoch(
        (json["dt"] + timezoneOffset) * 1000);
    var day = DateFormat('EEEE').format(date);
    return DailyList(
      day: day,
      icon: json["weather"][0]["icon"],
      minTemp: json["temp"]["min"].toInt(),
      maxTemp: json["temp"]["max"].toInt(),
    );
  }
}

class Cities {
  String city;
  double lat;
  double lon;

  Cities({
    required this.city,
    required this.lat,
    required this.lon,
  });

  factory Cities.fromJSON(Map<String, dynamic> json) {
    return Cities(
      city: json["name"],
      lat: json["coord"]["lat"].toDouble(),
      lon: json["coord"]["lon"].toDouble(),
    );
  }

  factory Cities.fromDB(Map<String, dynamic> map) {
    return Cities(
      city: map["city"],
      lat: map["lat"],
      lon: map["lon"],
    );
  }

  static List<Cities> listFromJson(List<dynamic> body) =>
      body.map((e) => Cities.fromJSON(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        "name": city,
        "coord": {"lat": lat, "lon": lon},
      };

  static String jsonFromList(List<Cities> citiesList) =>
      jsonEncode(citiesList.map((e) => e.toJson()).toList());

  factory Cities.fromWeather(AllWeather item) {
    return Cities(
      city: item.city,
      lat: item.lat,
      lon: item.lon,
    );
  }
}
