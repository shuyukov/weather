import 'package:flutter/material.dart';

class Config {

static ThemeData appTheme = ThemeData(
  fontFamily: "Roboto",
  inputDecorationTheme: InputDecorationTheme(
    border: inputBorder,
    enabledBorder: inputBorder,
    focusedBorder: inputBorder,
  ),
);

static TextStyle headline1 = const TextStyle(
  fontFamily: "Roboto",  
  fontSize: 40,
  fontWeight: FontWeight.w100,
  color: Colors.white,
);

static TextStyle bodyText1 = const TextStyle(
  fontFamily: "Roboto",
  fontSize: 14,
  fontWeight: FontWeight.w300,
  color: Colors.white,
);

static InputBorder inputBorder = OutlineInputBorder(
  borderSide: const BorderSide(
    color: Colors.white    
  ),
  borderRadius: BorderRadius.circular(30),
);
}