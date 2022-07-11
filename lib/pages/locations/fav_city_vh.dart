import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/config.dart';

class FavCityVH extends StatelessWidget {
  const FavCityVH({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      bloc: context.read<WeatherBloc>(),
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.citiesList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => context.read<WeatherBloc>().add(
                            RemoveCityEvent(state.citiesList[index].city)),
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
                              state.citiesList[index].city,
                              maxLines: 1,
                              style: Config.headline1.copyWith(fontSize: 24),
                            ),
                            Text(
                              state.citiesList[index].description,
                              style: Config.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                              "images/conditions/${state.citiesList[index].icon}.svg",
                              height: 40),
                          const SizedBox(width: 10),
                          Text(
                            "${state.citiesList[index].temp}°C",
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
          },
        );
      },
    );
  }
}
