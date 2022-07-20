part of 'weather_bloc.dart';

abstract class WeatherEvent {}

class LoadingHintsEvent extends WeatherEvent{
  final String enteredText;
  LoadingHintsEvent(this.enteredText);
}

class AddCityEvent extends WeatherEvent {
  final String selectedCity;
  AddCityEvent(this.selectedCity);
}

class LoadingCitiesEvent extends WeatherEvent {
}

class RemoveCityEvent extends WeatherEvent {
  final String selectedCity;
  RemoveCityEvent(this.selectedCity);
}

class ToLocationsEvent extends WeatherEvent {}
