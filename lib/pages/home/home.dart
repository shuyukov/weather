import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather/config.dart';
import 'package:weather/models/model.dart';
import 'package:weather/pages/home/current.dart';
import 'package:weather/pages/home/daily.dart';
import 'package:weather/pages/home/hourly.dart';
import 'package:weather/pages/locations/locations.dart';
import 'package:weather/services/weather.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = PageController();
  List<AllWeather> citiesList = [];
  bool isLoading = true;

  @override
  void initState() {
    getFavCitiesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              isLoading == true
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 3,
                        ),
                      ),
                    )
                  : (citiesList.isEmpty)
                      ? Expanded(
                          child: Center(
                            child: Text(
                              "There are no cities here yet.\nTap the button below to add.",
                              style: Config.bodyText1
                                  .copyWith(fontSize: 16, height: 1.5),
                            ),
                          ),
                        )
                      : Expanded(
                          child: PageView.builder(
                            controller: controller,
                            itemCount: citiesList.length,
                            itemBuilder: (context, index) {
                              final cityWeather = citiesList[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    CurrentForecast(items: cityWeather),
                                    const SizedBox(height: 20),
                                    HourlyForecast(
                                        items: cityWeather.hourlyWeather),
                                    const SizedBox(height: 20),
                                    Expanded(
                                      child: DailyForecast(
                                          items: cityWeather.dailyWeather),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 32),
                    const Spacer(),
                    SmoothPageIndicator(
                      controller: controller,
                      count: citiesList.length,
                      effect: const ScrollingDotsEffect(
                        dotColor: Color.fromRGBO(51, 164, 243, 1),
                        activeDotColor: Colors.white,
                        dotWidth: 7,
                        dotHeight: 7,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => toLocations(context),
                      child: SvgPicture.asset("images/locations.svg"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future toLocations(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Locations()),
    );
    getFavCitiesList();
  }

  Future getFavCitiesList() async {
    final items = await WeatherService().getFavWeatherList();
    setState(() {
      citiesList = items;
    });
    isLoading = false;
  }
}