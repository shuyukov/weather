import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/config.dart';
import 'package:weather/pages/locations/fav_city_vh.dart';
import 'package:weather/pages/locations/hint_vh.dart';
import 'package:weather/ui_kit/error_message.dart';
import 'package:weather/ui_kit/loader.dart';

class Locations extends StatelessWidget {
  Locations({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is ClearTextFieldState) {
            _controller.clear();
          }
        },
        child: GestureDetector(
          onLongPress: () async {
            context.read<WeatherBloc>().add(LoadingCitiesEvent());
          },
          child: Container(
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
                        onTap: () {
                          Navigator.of(context).pop();
                        },
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
                    onChanged: (text) => context
                        .read<WeatherBloc>()
                        .add(LoadingHintsEvent(text)),
                  ),
                  const SizedBox(height: 5),
                  BlocBuilder<WeatherBloc, WeatherState>(
                    bloc: context.read<WeatherBloc>(),
                    builder: (context, state) {
                      return SizedBox(
                        height: 30,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.hintsList.length,
                          itemBuilder: (context, index) =>
                              HintVH(item: state.hintsList[index]),
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  BlocBuilder<WeatherBloc, WeatherState>(
                    bloc: context.read<WeatherBloc>()
                      ..add(LoadingCitiesEvent()),
                    builder: (context, state) {
                      return Expanded(
                        child: Stack(
                          children: [
                            if (state is LoadedListsState) ...[
                              const FavCityVH(),
                            ] else if (state is NetworkErrorState) ...[
                              const ErrorMessage()
                            ] else ...[
                              const CircularLoader()
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
