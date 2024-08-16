import 'package:flutter/material.dart';
import 'package:internalsystem/components/textfieldstring.dart';
import 'package:internalsystem/utils/responsive.dart';
import 'package:internalsystem/widgets/main/header_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isDesktopLow = Responsive.isDesktopLow(context);
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        const HeaderWidget(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Container(
                    padding: isDesktop
                        ? EdgeInsets.symmetric(
                            horizontal: isDesktopLow
                                ? size.width * 0.07
                                : size.width * 0.13,
                            vertical: 0)
                        : const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            "Registrar novo usuário",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Center(
                          child: Text(
                            "Faça o registro de um novo usuário para utilizar o sistema.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Dados Pessoais",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        doubleTextField(
                          icon: Icon(MdiIcons.accountOutline),
                          hintText: "Digite seu nome completo",
                          shouldValidate: true,
                          onChanged: (value) {},
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Digite seu nome completo";
                            }
                            return null;
                          },
                          icon2: Icon(MdiIcons.emailOutline),
                          hintText2: "Digite seu E-mail",
                          shouldValidate2: true,
                          onChanged2: (value) {},
                          validator2: (text) {
                            if (text!.isEmpty) {
                              return "Digite um E-mail";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),
                        doubleTextField(
                          icon: Icon(MdiIcons.accountOutline),
                          hintText: "Digite seu CPF",
                          shouldValidate: true,
                          onChanged: (value) {},
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Digite seu CPF";
                            }
                            return null;
                          },

                          icon2: Icon(MdiIcons.emailOutline),
                          hintText2: "Digite seu Telefone",
                          shouldValidate2: true,
                          onChanged2: (value) {},
                          validator2: (text) {
                            if (text!.isEmpty) {
                              return "Digite seu Telefone";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        doubleTextField(
                          icon: Icon(MdiIcons.accountOutline),
                          hintText: "Digite seu CPF",
                          shouldValidate: true,
                          onChanged: (value) {},
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Digite seu CPF";
                            }
                            return null;
                          },

                          icon2: Icon(MdiIcons.emailOutline),
                          hintText2: "Digite seu Telefone",
                          shouldValidate2: true,
                          onChanged2: (value) {},
                          validator2: (text) {
                            if (text!.isEmpty) {
                              return "Digite seu Telefone";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        doubleTextField(
                          icon: Icon(MdiIcons.accountOutline),
                          hintText: "Digite seu CPF",
                          shouldValidate: true,
                          onChanged: (value) {},
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Digite seu CPF";
                            }
                            return null;
                          },

                          icon2: Icon(MdiIcons.emailOutline),
                          hintText2: "Digite seu Telefone",
                          shouldValidate2: true,
                          onChanged2: (value) {},
                          validator2: (text) {
                            if (text!.isEmpty) {
                              return "Digite seu Telefone";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        doubleTextField(
                          icon: Icon(MdiIcons.accountOutline),
                          hintText: "Digite seu CPF",
                          shouldValidate: true,
                          onChanged: (value) {},
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Digite seu CPF";
                            }
                            return null;
                          },

                          icon2: Icon(MdiIcons.emailOutline),
                          hintText2: "Digite seu Telefone",
                          shouldValidate2: true,
                          onChanged2: (value) {},
                          validator2: (text) {
                            if (text!.isEmpty) {
                              return "Digite seu Telefone";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        doubleTextField(
                          icon: Icon(MdiIcons.accountOutline),
                          hintText: "Digite seu CPF",
                          shouldValidate: true,
                          onChanged: (value) {},
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Digite seu CPF";
                            }
                            return null;
                          },

                          icon2: Icon(MdiIcons.emailOutline),
                          hintText2: "Digite seu Telefone",
                          shouldValidate2: true,
                          onChanged2: (value) {},
                          validator2: (text) {
                            if (text!.isEmpty) {
                              return "Digite seu Telefone";
                            }
                            return null;
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget doubleTextField(
      {final TextEditingController? controller,
      required final String hintText,
      required final Icon icon,
      required final bool shouldValidate,
      final String? Function(String?)? validator,
      final Widget? suffixIcon,
      final Function(String)? onChanged,
      final bool? enabled,
      final TextEditingController? controller2,
      required final String hintText2,
      required final Icon icon2,
      required final bool shouldValidate2,
      final String? Function(String?)? validator2,
      final Widget? suffixIcon2,
      final Function(String)? onChanged2,
      final bool? enabled2}) {

    final isDesktop = Responsive.isDesktop(context);

    return isDesktop
        ? Row(
            children: [
              Expanded(
                child: TextFieldString(
                  icon: icon,
                  hintText: hintText,
                  shouldValidate: shouldValidate,
                  onChanged: onChanged,
                  validator: validator,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFieldString(
                    icon: icon2,
                    hintText: hintText2,
                    shouldValidate: shouldValidate2,
                    onChanged: onChanged2,
                    validator: validator2),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFieldString(
                icon: icon,
                hintText: hintText,
                shouldValidate: shouldValidate,
                onChanged: onChanged,
                validator: validator,
              ),
              const SizedBox(height: 20),
              TextFieldString(
                  icon: icon2,
                  hintText: hintText2,
                  shouldValidate: shouldValidate2,
                  onChanged: onChanged2,
                  validator: validator2),
            ],
          );
  }
}
