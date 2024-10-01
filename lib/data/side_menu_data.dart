import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SideMenuData {
  final List<Map<String, dynamic>> allMenuOptions = [
    {
      'text': 'Home',
      'icon': MdiIcons.home,
      'route': '/home'
    },
    {
      'text': 'Register',
      'icon': MdiIcons.accountSupervisor,
      'route': '/register',
    },
    {
      'text': 'Usuários',
      'icon': MdiIcons.accountMultiplePlus,
      'route': '/users',
    }
  ];
}