import 'package:flutter/material.dart';
import 'package:weather/config.dart';
import 'package:weather/pages/home/home.dart';
import 'package:weather/repositories/local.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        initialData: null,
        future: initServices(context),
        builder: (_,__) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(0, 188, 248, 1),
                    Color.fromRGBO(1, 95, 231, 1)
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  "Weather",
                  style: Config.headline1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        });
  }

  Future initServices(BuildContext context) async {
    return StorageRepository().getCitiesList().then((value) =>
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const Home())));
  }
}
