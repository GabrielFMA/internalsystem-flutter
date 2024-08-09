import 'package:flutter/material.dart';
import 'package:internalsystem/const/const.dart';
import 'package:internalsystem/util/responsive.dart';
import 'package:internalsystem/widgets/main/screen_widget.dart';
import 'package:internalsystem/widgets/main/side_menu_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildLoadingScreen();
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error loading data: ${snapshot.error}')),
          );
        } else {
          return _buildContent(context);
        }
      },
    );
  }

  Widget _buildContent(BuildContext context) {
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
              child: Container(
                child: const ScreenWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
