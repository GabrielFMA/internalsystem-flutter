import 'package:flutter/material.dart';
import 'package:internalsystem/store/request_store.dart';
import 'package:internalsystem/widgets/main/split_screen.dart';
import 'package:internalsystem/widgets/users/user_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  final Widget screen;

  const MainScreen({super.key, required this.screen});

  Future<void> _loadData(BuildContext context) async {
    if (screen is UserWidget) {
      final store = Provider.of<RequestStore>(context, listen: false);
      store.startListeningToData('users', information: [
        'address',
        'cpf',
        'email',
        'id',
        'name',
        'phone',
        'role'
      ]);
      print(store.fetchedData);
    }
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _loadData(context),
      builder: (context, snapshot) {
        bool isLoading = snapshot.connectionState == ConnectionState.waiting;

        return splitScreen(context, screen, isLoading);
      },
    );
  }
}
