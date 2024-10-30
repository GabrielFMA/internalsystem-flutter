import 'package:flutter/material.dart';
import 'package:internalsystem/data/permissions_data.dart';
import 'package:internalsystem/screens/error_screen.dart';
import 'package:internalsystem/stores/auth_store.dart';
import 'package:internalsystem/widgets/home/home_widget.dart';
import 'package:provider/provider.dart';

Future<Widget> checkPermissionForScreen(
    BuildContext context, Widget screen) async {
  if (screen is HomeWidget) return const HomeWidget();

  return await _getUserPermission(context, _getPermissionForScreen(screen))
      ? screen
      : const ErrorScreen(
          message: 'Você não tem permissão', 
          returnMessage: 'Retornando para a tela inicial',
        );
}

String _getPermissionForScreen(Widget screen) {
  for (var route in PermissionsData().permissionsRoutes) {
    if (screen.runtimeType == route['screen']) {
      return route['permission'];
    }
  }
  return 'notPermission';
}

Future<bool> _getUserPermission(BuildContext context, String permission) async {
  final authStore = Provider.of<AuthStore>(context, listen: false);

  return authStore.getUser?.permissions?[permission] ?? true;
}
