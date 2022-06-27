import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/config.dart';
import 'package:weather/models/model.dart';

class CurrentForecast extends StatelessWidget {
  const CurrentForecast ({ Key? key, required this.items}) : super(key: key);
  final AllWeather items;
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),        
        Text(items.city, style: Config.bodyText1.copyWith(fontSize: 24)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("images/conditions/${items.icon}.svg", height: 60),
            const SizedBox(width: 10),
            RichText(
              text: TextSpan(
                style: Config.headline1,
                children: [
                  TextSpan(text: "${items.temp}", style: const TextStyle(fontSize: 96)),
                  const TextSpan(text: "°C", style: TextStyle(fontSize: 36)),
                ],
              ),
            ),
          ],
        ),
        Text(items.description, style: Config.bodyText1.copyWith(fontSize: 16)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("images/current/wind.svg"),
            const SizedBox(width: 10),
            Text("Wind:  ${items.wind} m/sec", style: Config.bodyText1),
            const SizedBox(width: 20),
            SvgPicture.asset("images/current/humidity.svg"),
            const SizedBox(width: 10),
            Text("Humidity:  ${items.humidity}%", style: Config.bodyText1),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("images/current/feelsLike.svg"),
            const SizedBox(width: 10),
            Text("Feels like:  ${items.feelsLike}°C", style: Config.bodyText1),
            const SizedBox(width: 20),
            SvgPicture.asset("images/current/pressure.svg"),
            const SizedBox(width: 10),
            Text("Pressure:  ${items.pressure}", style: Config.bodyText1),
          ],
        ),
      ],
    );
  }
}