import 'package:flutter/material.dart';
import 'package:internalsystem/screens/error_screen.dart';
import 'package:internalsystem/stores/auth_store.dart';
import 'package:internalsystem/stores/request_store.dart';
import 'package:internalsystem/widgets/main/register_widget.dart';
import 'package:internalsystem/widgets/main/home_widget.dart';
import 'package:provider/provider.dart';

Future<Widget> permissionCheck(
  BuildContext context,
  Widget screen,
) async {
  switch (screen.runtimeType) {
    case RegisterWidget:
      return await _checkPermission(screen, context, 'enterRegisterScreen');
    default:
      return const HomeWidget();
  }
}

Future<Widget> _checkPermission(
    Widget widget, BuildContext context, String permission) async {
  final authStore = Provider.of<AuthStore>(context, listen: false);
  final requestStore = Provider.of<RequestStore>(context, listen: false);

  final hasPermission = await requestStore.fetchSpecificInformation(
    'users',
    document: authStore.getUser!.id!,
    secondCollection: 'permissions',
    permission,
    true,
  );

  if (hasPermission ?? false) {
    return widget;
  } else {
    return const ErrorScreen(
      message: 'Você não tem permissão',
      returnMessage: 'Retornando para a tela inicial',
    );
  }
}
