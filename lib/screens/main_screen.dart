import 'package:flutter/material.dart';
import 'package:internalsystem/const/const.dart';
import 'package:internalsystem/util/responsive.dart';
import 'package:internalsystem/widgets/main/screen_widget.dart';
import 'package:internalsystem/widgets/main/side_menu_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      drawerScrimColor: const Color.fromARGB(24, 0, 0, 0),
      drawer: !isDesktop 
        ? Drawer(
            child: Container(
              color: menuColor, // Defina a cor de fundo do Drawer aqui
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
                child: SizedBox(
                  child: SideMenuWidget(),
                ),
              ),
            Expanded(
              flex: 10,
              child: Container(
                child: const ScreenWidget()
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}
