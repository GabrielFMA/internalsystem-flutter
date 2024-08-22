import 'package:flutter/material.dart';
import 'package:internalsystem/screens/error_screen.dart';
import 'package:internalsystem/stores/auth_store.dart';
import 'package:internalsystem/stores/request_store.dart';
import 'package:internalsystem/widgets/main/register_widget.dart';
import 'package:internalsystem/widgets/main/screen_widget.dart';
import 'package:provider/provider.dart';

Map<String, dynamic> _internalSystemMap = {};

Future<Widget> permissionCheck(BuildContext context, Widget screen) async {
  final userId = Provider.of<AuthStore>(context, listen: false).getUser?.id;
  if (userId == null) {
    return const ErrorScreen(
      message: 'Usuário não identificado',
      returnMessage: 'Retornando para a tela inicial',
    );
  }

  final requestStore = Provider.of<RequestStore>(context, listen: false);

  final fetchData = await requestStore.fetchSecondaryData(
    'users',
    'permissions',
    userId,
  );

  _internalSystemMap = fetchData.firstWhere(
    (map) => map['id'] == 'internalSystem',
    orElse: () => <String, dynamic>{},
  );

  switch (screen.runtimeType) {
    case const (RegisterWidget):
      return _checkPermission(screen, 'use.register');
    default:
      return const ScreenWidget();
  }
}

Widget _checkPermission(Widget widget, String permission) {
  if (_internalSystemMap['permissions']?[permission] ?? false) {
    return widget;
  } else {
    return const ErrorScreen(
      message: 'Você não tem permissão',
      returnMessage: 'Retornando para a tela inicial',
    );
  }
}
