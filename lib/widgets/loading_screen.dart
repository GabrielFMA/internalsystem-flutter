import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/widgets/main/header_widget.dart';

Widget buildLoadingScreen() {
  return Scaffold(
    body: Column(
      children: [
        const HeaderWidget(), // Header fixo no topo
        Expanded(
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: backgroundColor,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}