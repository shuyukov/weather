import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/config.dart';
import 'package:weather/models/model.dart';

class ListOfCities extends StatelessWidget {
  const ListOfCities({ Key? key, required this.cityWeather, required this.onDismissed}) : super(key: key);

  final AllWeather cityWeather;
  final ValueChanged<AllWeather> onDismissed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => onDismissed(cityWeather),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromRGBO(51, 164, 243, 1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cityWeather.city,
                      maxLines: 1,
                      style: Config.headline1.copyWith(fontSize: 24),
                    ),
                    Text(
                      cityWeather.description,
                      style: Config.bodyText1,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset("images/conditions/${cityWeather.icon}.svg",
                      height: 40),
                  const SizedBox(width: 10),
                  Text(
                    "${cityWeather.temp}°C",
                    style: Config.bodyText1.copyWith(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.centerRight,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
      ),
    );
  }
}

