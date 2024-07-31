import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internalsystem/components/textfieldstring.dart';
import 'package:internalsystem/components/textfieldstring_password.dart';
import 'package:internalsystem/const/const.dart';
import 'package:internalsystem/store/auth_store.dart';
import 'package:internalsystem/util/responsive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}


class _LoginWidgetState extends State<LoginWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final isDesktop = Responsive.isDesktop(context);

    final store = Provider.of<AuthStore>(context);

    return SizedBox.expand(
      child: Container(
        color: backgroundColor,
        padding:
            isDesktop ? const EdgeInsets.all(40) : const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!isDesktop)
                        Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 150,
                            height: 150,
                          ),
                        ),
                      const SizedBox(height: 20),
                      TextFieldString(
                        icon: Icon(MdiIcons.emailOutline),
                        hintText: "Digite seu email",
                        text: _emailController.text,
                        shouldValidate: true,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Digite um e-mail";
                          }
                          store.setEmail(text);
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldStringPassword(
                        icon: MdiIcons.lockOutline,
                        iconVisibility: MdiIcons.eyeOutline,
                        iconNotVisibility: MdiIcons.eyeOffOutline,
                        hintText: "Digite sua senha",
                        text: _passwordController.text,
                        shouldValidate: true,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Digite uma senha";
                          }
                          store.setPassword(text);
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45),
                                gradient: const LinearGradient(
                                  colors: <Color>[
                                    colorOneGradient,
                                    colorTwoGradient,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              width: width, // Define a largura do botão
                              height: 55, // Define a altura do botão
                              child: TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await store.loginWithEmailAndPassword(() {
                                      Navigator.of(context)
                                          .pushReplacementNamed('/home');
                                    });
                                  }
                                },
                                style: TextButton.styleFrom(
                                  shadowColor:
                                      Colors.transparent, // Remove a sombra
                                  side: BorderSide(
                                    color: Colors.transparent,
                                  ), // Remove a borda
                                  padding: EdgeInsets
                                      .zero, // Remove o padding interno
                                  backgroundColor: Colors
                                      .transparent, // Torna o fundo do botão transparente
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                child: const Text(
                                  "LOGIN",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
