import 'package:flutter/material.dart';
import 'package:internalsystem/components/textfieldstring.dart';
import 'package:internalsystem/components/textfieldstring_password.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/utils/navigation_utils.dart';
import 'package:internalsystem/utils/responsive.dart';
import 'package:internalsystem/widgets/register/permissions_widget.dart';
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
                            icon: Icon(MdiIcons.phoneOutline),
                            hintText: "Digite seu o número de telefone",
                            shouldValidate: true,
                            onChanged: (value) {},
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Digite o telefone completo";
                              }
                              return null;
                            },
                            icon2: Icon(MdiIcons.cardAccountDetailsOutline),
                            hintText2: "Digite um CPF",
                            shouldValidate2: true,
                            onChanged2: (value) {},
                            validator2: (text) {
                              if (text!.isEmpty) {
                                return "Digite um CPF";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          doublePasswordTextField(
                            passwordController: TextEditingController(),
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
                              return null;
                            },
                            confirmPasswordController: TextEditingController(),
                            confirmPasswordHintText: "Confirme sua senha",
                            confirmPasswordIcon: MdiIcons.lockOutline,
                            confirmPasswordVisibilityIcon:
                                MdiIcons.eyeOutline,
                            confirmPasswordNotVisibilityIcon:
                                MdiIcons.eyeOffOutline,
                            shouldValidateConfirmPassword: true,
                            onConfirmPasswordChanged: (value) {},
                            confirmPasswordValidator: (text) {
                              if (text!.isEmpty) {
                                return "Confirme sua senha";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          //PERMISSIONS BUTTON
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                showDialogPermissions(context);
                              },
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25),
                                backgroundColor: Colors.transparent,
                                side: const BorderSide(
                                    color: textFieldColor, width: 1.5),
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
            padding: isDesktop
                ? EdgeInsets.symmetric(
                    horizontal:
                        isDesktopLow ? size.width * 0.07 : size.width * 0.13,
                    vertical: 0)
                : const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  navigateTo('/home', context);
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 25),
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

  Widget doublePasswordTextField({
    final TextEditingController? passwordController,
    required final String passwordHintText,
    required final IconData passwordIcon,
    required final IconData passwordVisibilityIcon,
    required final IconData passwordNotVisibilityIcon,
    required final bool shouldValidatePassword,
    final String? Function(String?)? passwordValidator,
    final Function(String)? onPasswordChanged,
    final bool? passwordEnabled,
    final TextEditingController? confirmPasswordController,
    required final String confirmPasswordHintText,
    required final IconData confirmPasswordIcon,
    required final IconData confirmPasswordVisibilityIcon,
    required final IconData confirmPasswordNotVisibilityIcon,
    required final bool shouldValidateConfirmPassword,
    final String? Function(String?)? confirmPasswordValidator,
    final Function(String)? onConfirmPasswordChanged,
    final bool? confirmPasswordEnabled,
  }) {
    final isDesktop = Responsive.isDesktop(context);

    return isDesktop
        ? Row(
            children: [
              Expanded(
                child: TextFieldStringPassword(
                  controller: passwordController,
                  icon: passwordIcon,
                  iconVisibility: passwordVisibilityIcon,
                  iconNotVisibility: passwordNotVisibilityIcon,
                  hintText: passwordHintText,
                  shouldValidate: shouldValidatePassword,
                  validator: passwordValidator,
                  onChanged: onPasswordChanged,
                  enabled: passwordEnabled,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFieldStringPassword(
                  controller: confirmPasswordController,
                  icon: confirmPasswordIcon,
                  iconVisibility: confirmPasswordVisibilityIcon,
                  iconNotVisibility: confirmPasswordNotVisibilityIcon,
                  hintText: confirmPasswordHintText,
                  shouldValidate: shouldValidateConfirmPassword,
                  validator: confirmPasswordValidator,
                  onChanged: onConfirmPasswordChanged,
                  enabled: confirmPasswordEnabled,
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFieldStringPassword(
                controller: passwordController,
                icon: passwordIcon,
                iconVisibility: passwordVisibilityIcon,
                iconNotVisibility: passwordNotVisibilityIcon,
                hintText: passwordHintText,
                shouldValidate: shouldValidatePassword,
                validator: passwordValidator,
                onChanged: onPasswordChanged,
                enabled: passwordEnabled,
              ),
              const SizedBox(height: 20),
              TextFieldStringPassword(
                controller: confirmPasswordController,
                icon: confirmPasswordIcon,
                iconVisibility: confirmPasswordVisibilityIcon,
                iconNotVisibility: confirmPasswordNotVisibilityIcon,
                hintText: confirmPasswordHintText,
                shouldValidate: shouldValidateConfirmPassword,
                validator: confirmPasswordValidator,
                onChanged: onConfirmPasswordChanged,
                enabled: confirmPasswordEnabled,
              ),
            ],
          );
  }
}
