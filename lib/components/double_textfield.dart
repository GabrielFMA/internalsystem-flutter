import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:internalsystem/components/textfieldstring.dart';
import 'package:internalsystem/components/textfieldstring_password.dart';
import 'package:internalsystem/utils/responsive.dart';

class DoubleTextfield{
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
      final bool? enabled2,
      required final BuildContext context}) {
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
              const SizedBox(width: 10),
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
              const SizedBox(height: 10),
              TextFieldString(
                  icon: icon2,
                  hintText: hintText2,
                  shouldValidate: shouldValidate2,
                  onChanged: onChanged2,
                  validator: validator2),
            ],
          );
  }

  Widget doublePasswordTextField(
      {final TextEditingController? passwordController,
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
      required final BuildContext context}) {

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
              const SizedBox(width: 10),
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
              const SizedBox(height: 10),
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
