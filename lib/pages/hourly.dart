import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/config.dart';
import 'package:weather/models/model.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({ Key? key, required this.items}) : super(key: key);

  final List<HourlyList> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromRGBO(51, 164, 243, 1)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 24,
        itemBuilder: (BuildContext context, int index) {
          var item = items[index];
          var hour = item.hour;
          var icon = item.icon;
          var temperature = item.temp.toInt();
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("$hour", style: Config.bodyText1),                
                SvgPicture.asset("images/conditions/$icon.svg", height: 30,),
                Text("$temperature°C", style: Config.bodyText1.copyWith(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}