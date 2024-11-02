import 'package:flutter/material.dart';
import 'package:internalsystem/store/request_store.dart';
import 'package:internalsystem/widgets/main/split_screen.dart';
import 'package:internalsystem/widgets/users/user_widget.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  final Widget screen;

  const MainScreen({Key? key, required this.screen}) : super(key: key);

  Future<List<Map<String, dynamic>>?> _loadData(BuildContext context) async {
    if (screen is UserWidget) {
      final store = Provider.of<RequestStore>(context, listen: false);
      return await store.fetchData('users', information: [
        'address',
        'cpf',
        'email',
        'id',
        'name',
        'phone',
        'role'
      ]);
    }
    await Future.delayed(const Duration(seconds: 1));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: _loadData(context),
      builder: (context, snapshot) {
        bool isLoading = snapshot.connectionState == ConnectionState.waiting;

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error loading data: ${snapshot.error}')),
          );
        }

        return splitScreen(
          context,
          screen,
          isLoading,
          data: snapshot.data ?? [],
        );
      },
    );
  }
}