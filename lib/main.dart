import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/app_bloc.dart';
import 'package:weather/bloc/bloc_observer.dart';
import 'package:weather/pages/home/splash.dart';
import 'package:flutter/services.dart';
import 'package:weather/repositories/local.dart';
import 'config.dart';

void main() {
  return BlocOverrides.runZoned(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(App());
    },
    blocObserver: AppBlocObserver(),
  );
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final LocalRepositories _storageRepository = LocalRepositories();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _storageRepository,
      child: BlocProvider(
        lazy: false,
        create: (_) => AppBloc(
          storageRepository: _storageRepository,
        ),
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
