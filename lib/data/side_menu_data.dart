import 'package:flutter/material.dart';
import 'package:internalsystem/models/menu_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SideMenuData {
  final menu = <MenuModel>[
    MenuModel(icon: MdiIcons.homeOutline, title: "Home", route: "/home"),
    MenuModel(icon: MdiIcons.accountOutline, title: "Register", route: "/register"),
    MenuModel(icon: MdiIcons.cogOutline, title: "Settings", route: "/settings"),
  ];
}