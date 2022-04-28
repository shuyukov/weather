import 'package:flutter/material.dart';

Widget circularLoader() {
  return const Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      strokeWidth: 3,
    ),
  );
}
