import 'package:flutter/material.dart';
import 'package:internalsystem/components/double_textfield.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/store/register_store.dart';
import 'package:internalsystem/utils/navigation_utils.dart';
import 'package:internalsystem/utils/responsive.dart';
import 'package:internalsystem/widgets/popup/popup_confirm.dart';
import 'package:internalsystem/widgets/register/popup_permissions_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:internalsystem/models/register_model.dart';

final _formKey = GlobalKey<FormState>();

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late RegisterStore store;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    var registerModel = RegisterModel();
    store = Provider.of<RegisterStore>(context, listen: false);

    return Padding(
      padding: isDesktop
          ? const EdgeInsets.only(top: desktopHeader)
          : const EdgeInsets.only(top: mobileHeader),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: isDesktop ? 50 : 15),
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
                          const SizedBox(height: 20),
                          const Text(
                            "Dados Pessoais",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // DoubleTextfield para Nome e Email
                          DoubleTextfield().doubleTextField(
                            context: context,
                            icon: Icon(MdiIcons.accountOutline),
                            hintText: "Digite seu nome completo",
                            shouldValidate: true,
                            controller: _nameController,
                            onChanged: (value) {},
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Digite seu nome completo";
                              }
                              registerModel.name = text.toLowerCase();
                              return null;
                            },
                            icon2: Icon(MdiIcons.emailOutline),
                            hintText2: "Digite seu E-mail",
                            shouldValidate2: true,
                            controller2: _emailController,
                            onChanged2: (value) {},
                            validator2: (text) {
                              if (text!.isEmpty) {
                                return "Digite um E-mail";
                              }
                              registerModel.email = text.toLowerCase();
                              return null;
                            },
                          ),

                          const SizedBox(height: 10),

                          // DoubleTextfield para Telefone e CPF
                          DoubleTextfield().doubleTextField(
                            context: context,
                            icon: Icon(MdiIcons.phoneOutline),
                            hintText: "Digite seu número de telefone",
                            shouldValidate: true,
                            controller: _phoneController,
                            onChanged: (value) {},
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Digite o telefone completo";
                              }
                              registerModel.phone = text;
                              return null;
                            },
                            icon2: Icon(MdiIcons.cardAccountDetailsOutline),
                            hintText2: "Digite um CPF",
                            shouldValidate2: true,
                            controller2: _cpfController,
                            onChanged2: (value) {},
                            validator2: (text) {
                              if (text!.isEmpty) {
                                return "Digite um CPF";
                              }
                              registerModel.cpf = text;
                              return null;
                            },
                          ),

                          const SizedBox(height: 10),

                          // DoubleTextfield para Senha e Confirmar Senha
                          DoubleTextfield().doublePasswordTextField(
                            context: context,
                            passwordController: _passwordController,
                            passwordHintText: "Digite sua senha",
                            passwordIcon: MdiIcons.lockOutline,
                            passwordVisibilityIcon: MdiIcons.eyeOutline,
                            passwordNotVisibilityIcon: MdiIcons.eyeOffOutline,
                            shouldValidatePassword: true,
                            onPasswordChanged: (value) {},
                            passwordValidator: (text) {
                              if (text!.isEmpty) {
                                return "Digite sua senha";
                              } else if (text.length < 6) {
                                return "A senha deve ter pelo menos 6 caracteres";
                              }
                              registerModel.password = text;
                              return null;
                            },
                            confirmPasswordController:
                                _confirmPasswordController,
                            confirmPasswordHintText: "Confirme sua senha",
                            confirmPasswordIcon: MdiIcons.lockOutline,
                            confirmPasswordVisibilityIcon: MdiIcons.eyeOutline,
                            confirmPasswordNotVisibilityIcon:
                                MdiIcons.eyeOffOutline,
                            shouldValidateConfirmPassword: true,
                            onConfirmPasswordChanged: (value) {},
                            confirmPasswordValidator: (text) {
                              if (text!.isEmpty) {
                                return "Confirme sua senha";
                              }
                              if (registerModel.password != text) {
                                return "As senhas devem ser iguais";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 10),

                          // Botão de Permissões
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                showDialogPermissions(registerModel, context);
                              },
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 22),
                                backgroundColor: Colors.transparent,
                                side: const BorderSide(
                                    color: textFieldColor, width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                textStyle: const TextStyle(fontSize: 16),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                "Permissões",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isDesktop ? 50 : 15),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PopUpConfirm(() async {
                          await store.signUpWithEmailAndPassword(
                              registerModel, context, () {
                            setState(() {
                              _formKey.currentState?.reset();
                            });

                            Navigator.pop(context);
                            navigateTo('/home', context);
                          });
                          
                        }, 'Cadastrar Usuário', 'Confirme as informações antes:\n\nNome: ${registerModel.name} \nEmail: ${registerModel.email} \nTelefone: ${registerModel.phone} \nCPF: ${registerModel.cpf}',
                            'Confirmar', 'Cancelar');
                      },
                    );
                  }
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Concluir cadastro",
                  style: TextStyle(
                      color: backgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
