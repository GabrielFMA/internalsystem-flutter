import 'package:flutter/material.dart';

const backgroundColor = Color(0xFF202020);
const menuColor = Color(0xFF242424);
const iconHeaderColor = Colors.white;
const selectionColor = Color(0xFFFFFFFF);
const iconSelectionColor = Color(0xFF202020);
const colorOneGradient = Color(0xFF1ED6FF);
const colorTwoGradient = Color(0xFF5552E4);
const selectionTextColor = Color.fromARGB(117, 72, 187, 253);
const textFieldColor = Color(0xFFFFFFFF);
const borderColor = Color(0xFFFFFFFF);

const defaultPadding = 20.0;

const mobileHeader = 62.0;
const desktopHeader = 50.0;

Color colorIcon(int level){
  switch (level){
    case 0:
      return Colors.green;
    case 1:
      return Colors.yellow;
    case 2:
      return Colors.deepOrange;
    case 3:
      return Colors.red;
    default:
      return Colors.blue;
  }
}
