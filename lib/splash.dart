import 'package:flutter/material.dart';
import 'package:weather/config.dart';
import 'package:weather/pages/home/home.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),() =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) => const Home()))
    );
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromRGBO(0, 188, 248, 1), Color.fromRGBO(1, 95, 231, 1)],
          ),
        ),
        child: Center(
          child: Text("Weather", style: Config.headline1, textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}