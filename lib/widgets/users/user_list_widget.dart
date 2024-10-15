import 'package:flutter/material.dart';
import 'package:internalsystem/components/search_textfield.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserListWidget extends StatefulWidget {
  final List<Map<String, dynamic>> users;

  const UserListWidget({Key? key, required this.users}) : super(key: key);

  @override
  _UserListWidgetState createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  String _searchQuery = '';
  bool _showEmployees = true; // Estado para controlar a lista exibida

  @override
  Widget build(BuildContext context) {
    // Imprime os dados recebidos para debugar
    print('Users: ${widget.users}');

    final filteredUsers = widget.users.where((user) {
      final name = user['data']['name']?.toLowerCase() ?? '';
      final email = user['data']['email']?.toLowerCase() ?? '';
      return name.contains(_searchQuery.toLowerCase()) ||
          email.contains(_searchQuery.toLowerCase());
    }).toList();

    final usersToShow = filteredUsers.where((user) {
      return _showEmployees
          ? user['data']['role'] == 'funcionario'
          : user['data']['role'] == 'cliente';
    }).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lista de Usuários',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
          ),
          const Divider(color: Colors.grey, height: 20),
          SearchTextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showEmployees = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _showEmployees ? Colors.blue : Colors.grey,
                ),
                child: const Text('Funcionários'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showEmployees = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: !_showEmployees ? Colors.blue : Colors.grey,
                ),
                child: const Text('Clientes'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildUserColumn(usersToShow),
          ),
        ],
      ),
    );
  }

  Widget _buildUserColumn(List<Map<String, dynamic>> users) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _showEmployees ? 'Funcionários' : 'Clientes',
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        const Row(
          children: [
            Expanded(
              child: Text(
                'Nome',
                style: const TextStyle(fontSize: 12, color: Colors.white),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Text(
                'Email',
                style: const TextStyle(fontSize: 12, color: Colors.white),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Text(
                'CPF',
                style: const TextStyle(fontSize: 12, color: Colors.white),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        const Divider(color: Colors.grey),
        Expanded(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userData = users[index]['data'];
              return _buildUserCard(userData);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUserCard(Map<String, dynamic> userData) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      elevation: 4,
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: borderColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                '${userData['name'] ?? 'Nome não disponível'}',
                style: const TextStyle(fontSize: 14, color: Colors.white),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Text(
                '${userData['email'] ?? 'Email não disponível'}',
                style: const TextStyle(fontSize: 14, color: Colors.white),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Text(
                '${userData['cpf'] ?? 'CPF não disponível'}',
                style: const TextStyle(fontSize: 14, color: Colors.white),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
