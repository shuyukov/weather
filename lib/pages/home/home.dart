import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/config.dart';
import 'package:weather/pages/home/current.dart';
import 'package:weather/pages/home/daily.dart';
import 'package:weather/pages/home/hourly.dart';
import 'package:weather/pages/locations/locations.dart';
import 'package:weather/ui_kit/loader.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is ToLocationsState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Locations()),
            );
          }
        },
        child: Container(
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
          child: BlocBuilder<WeatherBloc, WeatherState>(
            bloc: context.read<WeatherBloc>()..add(LoadingCitiesEvent()),
            builder: (context, state) {
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: (state is LoadingCitiesListState)
                          ? const CircularLoader()
                          : (state.citiesList.isEmpty)
                              ? Center(
                                  child: Text(
                                    "There are no cities here yet.\nTap the button below to add.",
                                    style: Config.bodyText1
                                        .copyWith(fontSize: 16, height: 1.5),
                                  ),
                                )
                              : PageView.builder(
                                  controller: _controller,
                                  itemCount: state.citiesList.length,
                                  itemBuilder: (context, index) {
                                    final cityWeather = state.citiesList[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        children: [
                                          CurrentForecast(items: cityWeather),
                                          const SizedBox(height: 20),
                                          HourlyForecast(
                                              items: cityWeather.hourlyWeather),
                                          const SizedBox(height: 20),
                                          Expanded(
                                            child: DailyForecast(
                                                items:
                                                    cityWeather.dailyWeather),
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
                          (state.citiesList.isNotEmpty)
                              ? SmoothPageIndicator(
                                  controller: _controller,
                                  count: state.citiesList.length,
                                  effect: const ScrollingDotsEffect(
                                    dotColor: Color.fromRGBO(51, 164, 243, 1),
                                    activeDotColor: Colors.white,
                                    dotWidth: 7,
                                    dotHeight: 7,
                                  ),
                                )
                              : const Spacer(),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => context
                                .read<WeatherBloc>()
                                .add(ToLocationsEvent()),
                            child: SvgPicture.asset("images/locations.svg"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
