part of 'weather_bloc.dart';

abstract class WeatherState {
  final List<AllWeather> citiesList;
  final List<Cities> hintsList;
  WeatherState({this.citiesList = const [], this.hintsList = const []});
}

class LoadingCitiesListState extends WeatherState {}

class LoadedListsState extends WeatherState {
  LoadedListsState(
      {required List<AllWeather> citiesList, List<Cities> hintsList = const []})
      : super(citiesList: citiesList, hintsList: hintsList);
}

class ToLocationsState extends WeatherState {}

class ToHomeState extends WeatherState {}

class ClearTextFieldState extends WeatherState {}

class NetworkErrorState extends WeatherState {}