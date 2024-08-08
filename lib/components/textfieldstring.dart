import 'package:flutter/material.dart';
import 'package:internalsystem/const/const.dart';

class TextFieldString extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final Icon icon;
  final bool shouldValidate;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final bool? enabled;

  const TextFieldString({
    super.key,
    this.controller,
    required this.icon,
    required this.hintText,
    required this.shouldValidate,
    required this.validator,
    this.onChanged,
    this.suffixIcon,
    this.enabled,
  });

  @override
  _TextFieldStringState createState() => _TextFieldStringState();
}

class _TextFieldStringState extends State<TextFieldString> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _textController = widget.controller!;
    } else {
      _textController = TextEditingController();
    }

    _textController.addListener(() {
      if (widget.onChanged != null) {
        widget.onChanged!(_textController.text);
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _textController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textController,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      validator: widget.shouldValidate ? widget.validator : null,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IconTheme(
            data: const IconThemeData(
                color: Colors.white),
            child: widget.icon,
          ),
        ),
        suffixIcon: widget.suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: const BorderSide(color: textFieldColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: const BorderSide(color: textFieldColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: const BorderSide(color: Colors.white38, width: 2),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      ),
      style: const TextStyle(color: textFieldColor),
    );
  }
}
