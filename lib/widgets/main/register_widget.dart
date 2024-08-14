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

    return Stack(
      children: [
        SingleChildScrollView(
            child: Padding(
            padding: EdgeInsets.only(top: !isDesktop ? 80 : 0), // Espaço para o header
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                    children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Registrar novo usuário",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Faça o registro de um novo usuário para utilizar o sistema.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: isDesktop
                          ? const EdgeInsets.symmetric(horizontal: 100, vertical: 20)
                          : const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: _buildNameEmail(isDesktop),
                    ),
                    Container(
                      padding: isDesktop
                          ? const EdgeInsets.symmetric(horizontal: 100, vertical: 0)
                          : const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: _buildCPFTelefone(isDesktop),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (!isDesktop)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: HeaderWidget(),
          ),
        
      ],
    );
  }

  Widget _buildNameEmail(bool isDesktop) {
    return isDesktop
        ? Row(
            children: [
              Expanded(
                child: TextFieldString(
                  icon: Icon(MdiIcons.accountOutline),
                  hintText: "Digite o nome completo",
                  shouldValidate: true,
                  onChanged: (value) {},
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Digite o nome completo";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 20), // Espaçamento entre os campos no modo desktop
              Expanded(
                child: TextFieldString(
                  icon: Icon(MdiIcons.emailOutline),
                  hintText: "Digite um e-mail",
                  shouldValidate: true,
                  onChanged: (value) {},
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Digite um e-mail";
                    }
                    return null;
                  },
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFieldString(
                icon: Icon(MdiIcons.accountOutline),
                hintText: "Digite o nome completo",
                shouldValidate: true,
                onChanged: (value) {},
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Digite o nome completo";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Espaçamento entre os campos no modo mobile
              TextFieldString(
                icon: Icon(MdiIcons.emailOutline),
                hintText: "Digite um e-mail",
                shouldValidate: true,
                onChanged: (value) {},
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Digite um e-mail";
                  }
                  return null;
                },
              ),
            ],
          );
  }

  Widget _buildCPFTelefone(bool isDesktop) {
    return isDesktop
        ? Row(
            children: [
              Expanded(
                child: TextFieldString(
                  icon: Icon(MdiIcons.phoneOutgoingOutline),
                  hintText: "Digite o telefone",
                  shouldValidate: true,
                  onChanged: (value) {},
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Digite o telefone";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 20), // Espaçamento entre os campos no modo desktop
              Expanded(
                child: TextFieldString(
                  icon: Icon(MdiIcons.cardAccountDetailsOutline),
                  hintText: "Digite o CPF",
                  shouldValidate: true,
                  onChanged: (value) {},
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Digite o CPF";
                    }
                    return null;
                  },
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFieldString(
                icon: Icon(MdiIcons.phoneOutgoingOutline),
                hintText: "Digite o telefone",
                shouldValidate: true,
                onChanged: (value) {},
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Digite o telefone";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Espaçamento entre os campos no modo mobile
              TextFieldString(
                icon: Icon(MdiIcons.cardAccountDetailsOutline),
                hintText: "Digite o CPF",
                shouldValidate: true,
                onChanged: (value) {},
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Digite o CPF";
                  }
                  return null;
                },
              ),
            ],
          );
  }
}
