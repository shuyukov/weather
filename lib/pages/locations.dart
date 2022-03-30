import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/config.dart';

class Locations extends StatefulWidget {
  const Locations({Key? key}) : super(key: key);

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(25, 50, 25, 25),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromRGBO(0, 188, 248, 1), Color.fromRGBO(1, 95, 231, 1)],
          ),
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => goToHome(context),
                child: SvgPicture.asset("images/back.svg"),
              ),
              Text("Select City", style: Config.bodyText1.copyWith(fontSize: 22)),
              SvgPicture.asset("images/add.svg"),
            ],
          ),
          const SizedBox(height: 40,),
          Image.asset("images/list.gif")
        ]),
      ),
    );
  }

  void goToHome(BuildContext context) {
    Navigator.of(context).pop();
  }
}
