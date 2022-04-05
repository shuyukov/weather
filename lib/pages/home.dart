import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/models/model.dart';
import 'package:weather/pages/current.dart';
import 'package:weather/pages/daily.dart';
import 'package:weather/pages/hourly.dart';
import 'package:weather/services/api.dart';
import 'package:weather/pages/locations.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Model? allWeather;

  @override
  void initState() {
    getCurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(0, 188, 248, 1),
              Color.fromRGBO(1, 95, 231, 1)
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              allWeather == null ? const SizedBox() : CurrentForecast(item: allWeather!),
              const SizedBox(height: 20),
              allWeather == null ? const SizedBox() : HourlyForecast(items: allWeather!.hourlyWeather),
              const SizedBox(height: 20),
              Expanded(child: allWeather == null ? const SizedBox() : DailyForecast(items: allWeather!.dailyWeather)),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.bottomRight,
                child:
                  GestureDetector(
                    onTap: () => goToLocations(context),
                    child: SvgPicture.asset("images/locations.svg"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void goToLocations(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const Locations()));
  }


  Future getCurrentWeather() async {
    Api().getCurrentWeather(37.422, -122.084).then((value) {
      setState(() {
        allWeather = value;
      });
    });
  }
}
