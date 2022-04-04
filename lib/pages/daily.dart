import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/config.dart';
import 'package:weather/models/model.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({ Key? key, required this.items }) : super(key: key);

  final List<DailyList> items;

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: const EdgeInsets.all(15),      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromRGBO(51, 164, 243, 1)),
      ),
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          var item = items[index];
          var day = item.day;
          var icon = item.icon;
          var minTemp = item.minTemp;
          var maxTemp = item.maxTemp;
          return Container(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 3, child: Text(day, style: Config.bodyText1)),                
                Expanded(flex: 3, child: SvgPicture.asset("images/conditions/$icon.svg", height: 15,)),
                Expanded(flex: 2, child: Text("$minTemp°C", style: Config.bodyText1)),
                Expanded(flex: 1, child: Text("$maxTemp°C", style: Config.bodyText1)),                
              ]),
          );
        },
      ),
    );
  }
}