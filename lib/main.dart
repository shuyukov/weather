import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/app_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/data_providers/local.dart';
import 'package:weather/data_providers/network.dart';
import 'package:weather/pages/home/splash.dart';
import 'package:flutter/services.dart';
import 'package:weather/repositories/cities_repository.dart';
import 'config.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final CitiesRepository _citiesRepository =
      CitiesRepository(LocalDataProvider(), ApiDataProvider());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _citiesRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (_) => AppBloc(
              _citiesRepository,
            ),
          ),
          BlocProvider(
            create: (_) => WeatherBloc(_citiesRepository),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      theme: Config.appTheme,
      home: const SplashScreen(),
    );
  }
}
