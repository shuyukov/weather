import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/config.dart';
import 'package:weather/models/model.dart';

class HintVH extends StatelessWidget {
  const HintVH({Key? key, required this.item}) : super(key: key);

  final Cities item;
  @override
  Widget build(BuildContext context) {
    return 
    ActionChip(
        label: Text(item.city, style: Config.bodyText1),
        backgroundColor: const Color.fromRGBO(117, 186, 255, 1),
        onPressed: () {
          context.read<WeatherBloc>().add(AddCityEvent(item.city));
        },
      );
  }
}