import 'package:flutter/material.dart';
import 'package:internalsystem/models/menu_model.dart';

class SideMenuData {
  final menu = const <MenuModel>[
    MenuModel(icon: Icons.home_outlined, title: "Home"),
    MenuModel(icon: Icons.person_outline, title: "Profile"),
    MenuModel(icon: Icons.settings_outlined, title: "Settings"),
  ];
}