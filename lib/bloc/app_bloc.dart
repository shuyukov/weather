import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/repositories/cities_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this._citiesRepository) : super(AppUninitialisedState()) {
    on<AppInitialisedEvent>(_onAppInitilised);
    _initServices();
  }

  final CitiesRepository _citiesRepository;

  void _onAppInitilised(AppInitialisedEvent event, Emitter<AppState> emit) {
    emit(AppInitialisedState());
  }

  void _initServices() async {
    await _citiesRepository.init();
    add(AppInitialisedEvent());
  }
}