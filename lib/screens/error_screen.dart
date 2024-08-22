import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';

class ErrorScreen extends StatefulWidget {
  final String message;
  final String returnMessage;

  const ErrorScreen({
    super.key,
    required this.message,
    required this.returnMessage,
  });

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textFieldColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.returnMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: textFieldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
