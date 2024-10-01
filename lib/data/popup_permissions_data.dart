import 'package:internalsystem/widgets/users/users_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PopupPermissionsData {
  final List<Map<String, dynamic>> permissionsUsers = [
    {
      'title': 'Permission delete user screen',
      'description': 'Deleta o acesso a uma tela em especifico',
      'permission': 'deleteUserAcessScreen',
    },
    {
      'title': 'Edit email user',
      'description': 'Editar email de um usuário do sistema interno',
      'permission': 'editUserEmailSystem',
    },
    {
      'title': 'Edit email user app',
      'description': 'Editar email de um usuário do aplicativo',
      'permission': 'editUserEmailApp',
    },
    
  ];

  final List<Map<String, dynamic>> permissionsRoutes = [
    {
      'title': 'Entry User Screen',
      'description': 'Editar email de um usuário do aplicativo',
      'permission': 'editUserEmailApp',
      'screen': UsersWidget(),
    },
    
  ];

  final List<Map<String, dynamic>> permissionsAdmin = [
    {
      'text': 'Home',
      'icon': MdiIcons.home,
      'route': '/home',
    },
  ];
}

