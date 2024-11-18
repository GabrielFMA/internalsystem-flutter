// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';

class PopUpConfirm extends StatefulWidget {
  final VoidCallback? onConfirm;
  final String title;
  final String description;
  final String buttonConfirm;
  final String buttonCancel;

  const PopUpConfirm(
    this.onConfirm,
    this.title,
    this.description,
    this.buttonConfirm,
    this.buttonCancel, {
    super.key,
  });

  @override
  _PopUpConfirmState createState() => _PopUpConfirmState();
}

class _PopUpConfirmState extends State<PopUpConfirm> {
  bool _isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
      ),
      backgroundColor: backgroundColor,
      content: Text(widget.description),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buttonDialog(
              text: widget.buttonConfirm,
              color: Colors.green,
              onPressed: _isConfirmed
                  ? null
                  : () async {
                      setState(() {
                        _isConfirmed = true;
                      });
                      if (widget.onConfirm != null) {
                        widget.onConfirm!();
                      }
                    },
            ),
            buttonDialog(
              text: widget.buttonCancel,
              color: Colors.red,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buttonDialog(
      {required String text, required Color color, VoidCallback? onPressed}) {
    return Container(
      height: 40,
      width: 105,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
