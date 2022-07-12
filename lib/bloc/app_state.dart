part of 'app_bloc.dart';

abstract class AppState {
  const AppState();
}
class AppUninitialisedState extends AppState{}

class AppInitialisedState extends AppState {}
