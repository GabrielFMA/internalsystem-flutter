import 'package:flutter/material.dart';
import 'package:internalsystem/const/const.dart';

class TextFieldString extends StatelessWidget {
  final String text;
  final String hintText;
  final Icon icon;
  final bool shouldValidate;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final bool? enabled;

  const TextFieldString({
    super.key,
    required this.icon,
    required this.hintText,
    required this.text,
    required this.shouldValidate,
    required this.validator,
    this.onChanged,
    this.suffixIcon,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController(text: text);

    return TextFormField(
      controller: _textController,
      onChanged: onChanged,
      enabled: enabled,
      validator: shouldValidate ? validator : null,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20), // Adiciona padding ao ícone
          child: icon,
        ),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45), // Manter a borda arredondada
          borderSide: const BorderSide(color: textFieldColor, width: 1.5), // Adicionar a borda com cor e largura
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45), // Manter a borda arredondada
          borderSide: const BorderSide(color: textFieldColor, width: 1.5), // Adicionar a borda com cor e largura
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45), // Manter a borda arredondada
          borderSide: const BorderSide(color: Colors.white38, width: 2), // Adicionar a borda com cor e largura
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        filled: true, // Permite preencher o fundo
        fillColor: Colors.transparent, // Fundo transparente
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20), // Padding interno
      ),
      style: TextStyle(color: textFieldColor),
    );
  }
}
