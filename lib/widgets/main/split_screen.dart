import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/screens/error_screen.dart';
import 'package:internalsystem/utils/responsive.dart';
import 'package:internalsystem/utils/verification_utils.dart';
import 'package:internalsystem/widgets/main/loading_screen.dart';
import 'package:internalsystem/widgets/main/header_widget.dart';
import 'package:internalsystem/widgets/main/side_menu_widget.dart';

Widget splitScreen(BuildContext context, Widget screen, bool isLoading) {
  final isDesktop = Responsive.isDesktop(context);

  return Scaffold(
    drawerScrimColor: const Color.fromARGB(24, 0, 0, 0),
    drawer: !isDesktop
        ? Drawer(
            child: Container(
              color: menuColor,
              child: const SideMenuWidget(),
            ),
          )
        : null,
    body: SafeArea(
      child: Row(
        children: [
          if (isDesktop)
            const Expanded(
              flex: 2,
              child: SideMenuWidget(),
            ),
          Expanded(
            flex: 10,
            child: Stack(
              children: [
                const HeaderWidget(),
                FutureBuilder<Widget>(
                  future: checkPermissionForScreen(context, screen),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    }
                    return const ErrorScreen(
                      message: 'Erro na tela',
                      returnMessage: 'Retornando para a tela inicial',
                    );
                  },
                ),
                if (isLoading)
                  Positioned.fill(
                    child: buildLoadingScreen(),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
