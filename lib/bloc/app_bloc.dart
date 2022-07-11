import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/repositories/cities_repository.dart';

enum AppState {
  uninitilised,
  initilised,
}

abstract class AppEvent {
  const AppEvent();
}

class AppInitilised extends AppEvent {}

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this._citiesRepository) : super(AppState.uninitilised) {
    on<AppInitilised>(_onAppInitilised);
    _initServices();
  }

  final CitiesRepository _citiesRepository;

  void _onAppInitilised(AppInitilised event, Emitter<AppState> emit) {
    emit(AppState.initilised);
  }

  void _initServices() async {
    await _citiesRepository.init();
    add(AppInitilised());
  }
}
