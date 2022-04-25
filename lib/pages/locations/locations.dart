import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/config.dart';
import 'package:weather/models/model.dart';
import 'package:weather/pages/locations/list.dart';
import 'package:weather/repositories/local.dart';
import 'package:weather/services/weather.dart';

class Locations extends StatefulWidget {
  const Locations({Key? key}) : super(key: key);

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  List<AllWeather> citiesList = [];
  bool isLoading = true;
  List<Cities> tipsList = [];
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    getFavCitiesList();
    controller.addListener(getHintsList);
    getHintsList();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => toHome(context),
                    child: SvgPicture.asset("images/back.svg"),
                  ),
                  Text("Select City",
                      style: Config.bodyText1.copyWith(fontSize: 22)),
                  const SizedBox(width: 32),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller,
                cursorColor: const Color.fromRGBO(147, 212, 255, 1),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: EdgeInsets.all(20.0),
                  labelStyle: TextStyle(
                    color: Color.fromRGBO(147, 212, 255, 1),
                  ),
                  labelText: "Search for a city",
                ),
                onSubmitted: setEnteredCity,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 30,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: tipsList.length,
                  itemBuilder: (context, index) => hintList(tipsList[index]),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                ),
              ),
              Expanded(
                child: isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 3,
                        ),
                      )
                    : ListView(
                        children: [
                          ...citiesList
                              .map(
                                (item) => ListOfCities(
                                  cityWeather: item,
                                  onDismissed: onDismissed,
                                ),
                              )
                              .toList(),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toHome(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onDismissed(AllWeather item) {
    setState(() {
      citiesList.remove(item);
      StorageRepository()
          .saveFavCities(citiesList.map((e) => Cities.fromWeather(e)).toList());
    });
  }

  Widget hintList(Cities e) => ActionChip(
        label: Text(e.city, style: Config.bodyText1),
        backgroundColor: const Color.fromRGBO(117, 186, 255, 1),
        onPressed: () {
          setEnteredCity(e.city);
        },
      );

  void setEnteredCity(String value) async {
    setState(() {
      isLoading = true;
    });
    final result = await WeatherService().getWeatherByCityName(value);
    if (result != null &&
        citiesList.where((e) => e.name == result.name).isEmpty) {
      citiesList.add(result);
      StorageRepository()
          .saveFavCities(citiesList.map((e) => Cities.fromWeather(e)).toList());
    }
    setState(() {
      isLoading = false;
      controller.text = "";
    });
  }

  Future getFavCitiesList() async {
    final items = await WeatherService().getFavWeatherList();
    setState(() {
      citiesList = items;
      isLoading = false;
    });
  }

  Future getHintsList() async {
    final items = await WeatherService().getTipsList(controller.text);
    setState(() {
      tipsList = items;
    });
  }
}
