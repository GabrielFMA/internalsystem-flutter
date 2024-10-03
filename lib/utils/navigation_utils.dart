import 'package:flutter/material.dart';

void navigateTo(String route, BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.of(context).pushReplacementNamed(route);
  });
}

Future<void> navigateToSomeBuilder(
    Widget pageBuilder, BuildContext context, int time) async {
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