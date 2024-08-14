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
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Container(
      child: Column(
        children: [
          if (!isDesktop)
            HeaderWidget(),
          TextFieldString(
            icon: Icon(MdiIcons.emailOutline),
            hintText: "Digite seu email",
            shouldValidate: true,
            onChanged: (value) {},
            validator: (text) {
              if (text!.isEmpty) {
                return "Digite um e-mail";
              }
              return null;
            },
          ),
          TextFieldString(
            icon: Icon(MdiIcons.emailOutline),
            hintText: "Digite seu email",
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
      ),
    );
  }
}
