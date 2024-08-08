import 'package:flutter/material.dart';

const backgroundColor = Color(0xFF202020);
const menuColor = Color(0xFF242424);
const selectionColor = Color(0xFFFFFFFF);
const iconSelectionColor = Color(0xFF202020);
const colorOneGradient = Color(0xFF1ED6FF);
const colorTwoGradient = Color(0xFF5552E4);
const selectionTextColor = Color.fromARGB(117, 72, 187, 253);
const textFieldColor = Color(0xFFFFFFFF);

const defaultPadding = 20.0;

void navigateTo(route, BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.of(context).pushReplacementNamed(route);
  });
}

Future<void> navigateToSomeBuilder(Widget pageBuilder, BuildContext context, int time) async {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => pageBuilder,
        opaque: false,
      ),
    );
  });
  await Future.delayed(Duration(milliseconds: time));
}

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
