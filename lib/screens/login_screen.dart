import 'package:flutter/material.dart';
import 'package:internalsystem/util/responsive.dart';
import 'package:internalsystem/widgets/login/login_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isDesktopLow = Responsive.isDesktopLow(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_login.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: isDesktop
              ? EdgeInsets.symmetric(
                  horizontal:
                      isDesktopLow ? size.width * 0.10 : size.width * 0.20,
                  vertical:
                      isDesktopLow ? size.width * 0.10 : size.width * 0.115)
              : const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Material(
            elevation: 30,
            child: Row(
              children: [
                if (isDesktop)
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Image.asset('assets/images/logo.png', width: 200, height: 200),
                    ), // Corrigido aqui
                  ),
                const Expanded(
                  flex: 1,
                  child: Center(
                    child: LoginWidget(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}