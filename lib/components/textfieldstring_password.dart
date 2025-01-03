import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';

class TextFieldStringPassword extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData icon;
  final IconData iconVisibility;
  final IconData iconNotVisibility;
  final bool shouldValidate;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool? enabled;

  const TextFieldStringPassword({
    super.key,
    this.controller,
    required this.icon,
    required this.iconVisibility,
    required this.iconNotVisibility,
    required this.hintText,
    required this.shouldValidate,
    required this.validator,
    this.onChanged,
    this.enabled, 
    onSubmitted, 
    textInputAction,
  });

  @override
  _TextFieldStringPasswordState createState() => _TextFieldStringPasswordState();
}

class _TextFieldStringPasswordState extends State<TextFieldStringPassword> {
  late TextEditingController _textController;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _textController = widget.controller!;
    } else {
      _textController = TextEditingController();
    }
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
      obscureText: _isObscure,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      validator: widget.shouldValidate ? widget.validator : null,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Icon(widget.icon, color: textFieldColor, size: 19,),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            icon: Icon(
              _isObscure ? widget.iconVisibility : widget.iconNotVisibility,
              color: textFieldColor, size: 19,
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textFieldColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textFieldColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white38, width: 1.5),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
      style: const TextStyle(color: textFieldColor),
    );
  }
}