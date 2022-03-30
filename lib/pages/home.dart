import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/models/model.dart';
// import 'package:weather/config.dart';
import 'package:weather/pages/current.dart';
import 'package:weather/services/api.dart';
// import 'package:weather/services/api.dart';
import 'locations.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Model? currentWeather;

  @override
  void initState() {
    getCurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(25, 50, 25, 25),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromRGBO(0, 188, 248, 1), Color.fromRGBO(1, 95, 231, 1)],
          ),
        ),
        child: Column(
          children: [
            currentWeather == null ? const SizedBox():
            CurrentForecast(item: currentWeather!,),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => goToLocations(context),
                  child: SvgPicture.asset("images/locations.svg"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  void goToLocations(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
    builder: (BuildContext context) => const Locations()));
  }

  Future getCurrentWeather() async {
    // final response = 
    Api().getCurrentWeather(33.44, -94.04).then((value){
      setState(() {
        currentWeather = value;
      });
    });
  }

}
