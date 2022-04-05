import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/config.dart';

class Locations extends StatelessWidget {
  const Locations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List cities = List.generate(15, (index) {
      return;
    });

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
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
        child: SafeArea(
          child: Column(
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => goToHome(context),
                  child: SvgPicture.asset("images/back.svg"),
                ),
                Text("Select City",
                    style: Config.bodyText1.copyWith(fontSize: 22)),
                const SizedBox(width: 32),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              cursorColor: const Color.fromRGBO(147, 212, 255, 1),
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.all(20.0),
                labelStyle: TextStyle(color: Color.fromRGBO(147, 212, 255, 1)),
                labelText: "Search for a city",
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: cities.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (_) {
                setState(() {
                  cities.removeAt(index);
                });
                },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color.fromRGBO(51, 164, 243, 1)),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text("Prague", maxLines: 1, style: Config.headline1.copyWith(fontSize: 24)),
                          Text("cloudy", style: Config.bodyText1,),
                        ],),),
                        Row(children: [
                          SvgPicture.asset("images/conditions/01d.svg", height: 40),
                          const SizedBox(width: 10),
                          Text("22°C", style: Config.bodyText1.copyWith(fontSize: 20)),
                        ],),
                    ]),
                  ),
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 5);
              }
            ),
          ),],),
        ),
      ),
    );
  }

  void goToHome(BuildContext context) {
    Navigator.of(context).pop();
  }

  void setState(Null Function() param0) {}
}