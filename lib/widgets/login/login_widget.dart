// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internalsystem/components/textfieldstring.dart';
import 'package:internalsystem/components/textfieldstring_password.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/models/auth_model.dart';
import 'package:internalsystem/models/text_error_model.dart';
import 'package:internalsystem/store/auth_store.dart';
import 'package:internalsystem/utils/error_messages.dart';
import 'package:internalsystem/utils/navigation_utils.dart';
import 'package:internalsystem/utils/responsive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  var textError = TextErrorModel(error: '');
  var authModel = AuthModel();
  bool _isProcessing = false;

  void _onButtonPressed() async {
    if (_formKey.currentState!.validate() && !_isProcessing) {
      setState(() {
        _isProcessing = true;
        textError = TextErrorModel(error: '');
      });
      await Future.delayed(const Duration(milliseconds: 1000));
      final store = Provider.of<AuthStore>(context, listen: false);
      await store.loginWithEmailAndPassword(authModel, textError, context, () {
        navigateTo('/home', context);
      });

      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final isDesktop = Responsive.isDesktop(context);

    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if (event is RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.enter) {
          _onButtonPressed();
        }
      },
      child: SizedBox.expand(
        child: Container(
          color: backgroundColor,
          padding:
              isDesktop ? const EdgeInsets.all(40) : const EdgeInsets.all(20),
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
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
                        const SizedBox(height: 40),
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
                          controller: widget.emailController,
                          shouldValidate: true,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            authModel.email = value;
                          },
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Digite um e-mail";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFieldStringPassword(
                          icon: MdiIcons.lockOutline,
                          iconVisibility: MdiIcons.eyeOutline,
                          iconNotVisibility: MdiIcons.eyeOffOutline,
                          hintText: "Digite sua senha",
                          controller: widget.passwordController,
                          shouldValidate: true,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {
                            authModel.password = value;
                          },
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Digite uma senha";
                            }
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
                                width: width,
                                height: 55,
                                child: TextButton(
                                  onPressed: _onButtonPressed,
                                  style: TextButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    side: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                    padding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
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
                        const SizedBox(height: 20),
                        customLoadingOrErrorWidget(
                            isLoading: _isProcessing, textError: textError),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
