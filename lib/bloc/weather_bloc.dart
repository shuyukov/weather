import 'package:bloc/bloc.dart';
import 'package:weather/models/model.dart';
import 'package:weather/repositories/cities_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._citiesRepository) : super(LoadingCitiesListState()) {
    on<LoadingCitiesEvent>(_getFavCitiesList);
    on<LoadingHintsEvent>(_getHintsList);
    on<AddCityEvent>(_setEnteredCity);
    on<RemoveCityEvent>(_removeFavCity);
    on<ToLocationsEvent>(_toLocations);
  }

  final CitiesRepository _citiesRepository;

  Future _getHintsList(
      LoadingHintsEvent event, Emitter<WeatherState> emit) async {
    final hintsList = await _citiesRepository.getListOfHints(event.enteredText);
    emit(LoadedListsState(citiesList: state.citiesList, hintsList: hintsList));
  }

  Future _setEnteredCity(AddCityEvent event, Emitter<WeatherState> emit) async {
    emit(LoadingCitiesListState());
    try {
      final result =
          await _citiesRepository.getWeatherByCity(event.selectedCity);
      final citiesList = await _citiesRepository.getWeatherForFavCities();
      if (citiesList.where((e) => e.city == result.city).isEmpty) {
        citiesList.add(result);
        _citiesRepository.saveFavCity(Cities.fromWeather(result));
        emit(ClearTextFieldState());
        emit(LoadedListsState(citiesList: citiesList));
      }
    } catch (_) {
      emit(ClearTextFieldState());
      emit(NetworkErrorState());
    }
  }

  Future _getFavCitiesList(
      LoadingCitiesEvent event, Emitter<WeatherState> emit) async {
    emit(LoadingCitiesListState());
    try {
      final citiesList = await _citiesRepository.getWeatherForFavCities();
      emit(LoadedListsState(citiesList: citiesList, hintsList: []));
    } catch (_) {
      emit(NetworkErrorState());
    }
  }

  void _removeFavCity(RemoveCityEvent event, Emitter<WeatherState> emit) async {
    final citiesList = state.citiesList;
    emit(LoadingCitiesListState());
    await _citiesRepository.removeFavCity(event.selectedCity);
    final newCitiesList = citiesList
        .where((element) => element.city != event.selectedCity)
        .toList();
    emit(LoadedListsState(citiesList: newCitiesList));
  }

  void _toLocations(ToLocationsEvent event, Emitter<WeatherState> emit) async {
    emit(ToLocationsState());
  }
}
