import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/widgets/main/header_widget.dart';

Widget buildLoadingScreen() {
  return const Scaffold(
    body: Column(
      children: [
        HeaderWidget(), // Header fixo no topo
        Expanded(
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: backgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}