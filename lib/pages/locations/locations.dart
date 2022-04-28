import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/config.dart';
import 'package:weather/models/model.dart';
import 'package:weather/pages/locations/list.dart';
import 'package:weather/repositories/local.dart';
import 'package:weather/services/weather.dart';
import 'package:weather/ui_kit/loader.dart';

class Locations extends StatefulWidget {
  const Locations({Key? key}) : super(key: key);

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  List<AllWeather> _citiesList = [];
  bool _isLoading = true;
  List<Cities> _tipsList = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    getFavCitiesList();
    _controller.addListener(getHintsList);
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
                controller: _controller,
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
              const SizedBox(height: 5),
              SizedBox(
                height: 30,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _tipsList.length,
                  itemBuilder: (context, index) => hintList(_tipsList[index]),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: _isLoading == true
                    ? circularLoader()
                    : ListView(
                        children: [
                          ..._citiesList
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
      _citiesList.remove(item);
      StorageRepository()
          .saveFavCities(_citiesList.map((e) => Cities.fromWeather(e)).toList());
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
      _isLoading = true;
    });
    final result = await WeatherService().getWeatherByCityName(value);
    if (result != null &&
        _citiesList.where((e) => e.name == result.name).isEmpty) {
      _citiesList.add(result);
      StorageRepository()
          .saveFavCities(_citiesList.map((e) => Cities.fromWeather(e)).toList());
    }
    setState(() {
      _isLoading = false;
      _controller.text = "";
    });
  }

  Future getFavCitiesList() async {
    final items = await WeatherService().getFavWeatherList();
    setState(() {
      _citiesList = items;
      _isLoading = false;
    });
  }

  Future getHintsList() async {
    final items = await WeatherService().getTipsList(_controller.text);
    setState(() {
      _tipsList = items;
    });
  }
}
