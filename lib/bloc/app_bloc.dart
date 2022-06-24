import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/repositories/local.dart';

enum AppState {
  uninitilised,
  initilised,
}

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppInitilised extends AppEvent {}

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required StorageRepository storageRepository})
      : _storageRepository = storageRepository,
        super(AppState.uninitilised) {
    on<AppInitilised>(_onAppInitilised);
    _initServices();
  }

  final StorageRepository _storageRepository;

  void _onAppInitilised(AppInitilised event, Emitter<AppState> emit) async {
    emit(AppState.initilised);
  }

  void _initServices() async {
    await _storageRepository.init();
    add(AppInitilised());
  }
}
