import 'package:flutter/material.dart';
import 'package:weather/config.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Failed to load weather data.\nLong tap will refresh the page.",
        textAlign: TextAlign.center,
        style: Config.bodyText1.copyWith(fontSize: 16, height: 1.5),
      ),
    );
  }
}