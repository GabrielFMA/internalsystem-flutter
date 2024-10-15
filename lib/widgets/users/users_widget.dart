import 'package:flutter/material.dart';
import 'package:internalsystem/stores/request_store.dart';
import 'package:internalsystem/widgets/users/user_list_widget.dart';
import 'package:provider/provider.dart';

class UsersWidget extends StatefulWidget {
  const UsersWidget({Key? key}) : super(key: key);

  @override
  State<UsersWidget> createState() => _UsersWidgetState();
}

class _UsersWidgetState extends State<UsersWidget> {
  late Future<List<Map<String, dynamic>>> _futureUsers;

  @override
  void initState() {
    super.initState();
    // Inicializando a chamada para buscar os dados dos usuários
    _fetchUsers();
  }

  void _fetchUsers() {
    final store = Provider.of<RequestStore>(context, listen: false);
    _futureUsers = store.fetchData('users', information: ['name', 'email', 'phone', 'cpf', 'role']);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _futureUsers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum usuário encontrado.'));
        }

        final users = snapshot.data!;

        // Retorna o UserListWidget com a lista de usuários
        return UserListWidget(users: users);
      },
    );
  }
}