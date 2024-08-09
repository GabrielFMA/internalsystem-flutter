import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';

Widget buildLoadingScreen() {
  return const Scaffold(
    body: Center(
      child: CircularProgressIndicator(
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    ),
  );
}
