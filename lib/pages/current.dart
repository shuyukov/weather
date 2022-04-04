import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/config.dart';
import 'package:weather/models/model.dart';

class CurrentForecast extends StatelessWidget {
  CurrentForecast ({ Key? key, required Model item}) : super(key: key){
    temperature = item.temperature;
    wind = item.wind;
    humidity = item.humidity;
    feelsLike = item.feelsLike;
    pressure = item.pressure;
    description = item.description;
    icon = item.icon;
  }
  late final int temperature;
  late final int wind;
  late final int humidity;
  late final int feelsLike;
  late final int pressure;
  late final String description;
  late final String icon;

 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Chicago", style: Config.bodyText1.copyWith(fontSize: 22)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("images/conditions/$icon.svg", height: 60),
            const SizedBox(width: 10),
            RichText(
              text: TextSpan(
                style: Config.headline1,
                children: [
                  TextSpan(text: "$temperature", style: const TextStyle(fontSize: 96)),
                  const TextSpan(text: "°C", style: TextStyle(fontSize: 36)),
                ],
              ),
            ),
          ],
        ),
        Text(description, style: Config.bodyText1.copyWith(fontSize: 16)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("images/current/wind.svg"),
            const SizedBox(width: 10),
            Text("Wind:  $wind m/sec", style: Config.bodyText1),
            const SizedBox(width: 20),
            SvgPicture.asset("images/current/humidity.svg"),
            const SizedBox(width: 10),
            Text("Humidity:  $humidity%", style: Config.bodyText1),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("images/current/feelsLike.svg"),
            const SizedBox(width: 10),
            Text("Feels like:  $feelsLike°C", style: Config.bodyText1),
            const SizedBox(width: 20),
            SvgPicture.asset("images/current/pressure.svg"),
            const SizedBox(width: 10),
            Text("Pressure:  $pressure", style: Config.bodyText1),
          ],
        ),
      ],
    );
  }
}