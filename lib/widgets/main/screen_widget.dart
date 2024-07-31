import 'package:flutter/material.dart';
import 'package:internalsystem/widgets/main/header_widget.dart';

class ScreenWidget extends StatelessWidget {
  const ScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HeaderWidget(),
      ],
    );
  }
}
