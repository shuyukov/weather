import 'package:flutter/material.dart';
import 'package:weather/pages/home/splash.dart';
import 'package:flutter/services.dart';
import 'config.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      theme: Config.appTheme,
      home: const SplashScreen(),
    );}
}
