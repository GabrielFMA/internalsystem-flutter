import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/utils/responsive.dart';
import 'package:internalsystem/widgets/loading_screen.dart';
import 'package:internalsystem/widgets/main/screen_widget.dart';
import 'package:internalsystem/widgets/main/side_menu_widget.dart';
import 'package:internalsystem/widgets/split_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
          return splitScreen(context, RegisterScreen());
        }
      },
    );
  }


}
