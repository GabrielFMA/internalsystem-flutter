import 'package:flutter/material.dart';
import 'package:internalsystem/widgets/split_screen.dart';

class MainScreen extends StatelessWidget {
  final Widget screen;

  const MainScreen({Key? key, required this.screen}) : super(key: key);

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _loadData(),
      builder: (context, snapshot) {
        bool isLoading = snapshot.connectionState == ConnectionState.waiting;

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error loading data: ${snapshot.error}')),
          );
        } else {
          return splitScreen(context, screen, isLoading);
        }
      },
    );
  }
}
