import 'package:flutter/material.dart';
import 'package:internalsystem/components/search_textfield.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/utils/responsive.dart';

class UserWidget extends StatefulWidget {
  final List<Map<String, dynamic>> users;
  const UserWidget({super.key, this.users = const []});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  String _searchQuery = '';
  String _selectedRole = 'funcionario';
  String _sortBy = 'name';
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final size = MediaQuery.of(context).size;

    final filteredUsers = widget.users.where((user) {
      final name = user['data']['name']?.toLowerCase() ?? '';
      final email = user['data']['email']?.toLowerCase() ?? '';
      return name.contains(_searchQuery.toLowerCase()) ||
          email.contains(_searchQuery.toLowerCase());
    }).toList();

    // Ordenando a lista com base no campo e direção
    filteredUsers.sort((a, b) {
      final aValue = a['data'][_sortBy] ?? '';
      final bValue = b['data'][_sortBy] ?? '';

      if (_isAscending) {
        return aValue.compareTo(bValue);
      } else {
        return bValue.compareTo(aValue);
      }
    });

    final usersToShow = filteredUsers.where((user) {
      if (_selectedRole == 'cliente') {
        return user['data']['role'] == 'cliente';
      } else {
        return user['data']['role'] != 'cliente';
      }
    }).toList();

    return Padding(
      padding: isDesktop
          ? const EdgeInsets.only(top: desktopHeader)
          : const EdgeInsets.only(top: mobileHeader),
      child: Column(
        children: [
          // Parte superior fixa
          _buildHeader(),

          // Parte rolável com a lista de usuários
          Expanded(
            child: ListView(
              children: [
                _buildUserColumn(usersToShow),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.symmetric(horizontal: isDesktop ? 50 : 15, vertical: 12),
      color: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const Center(
            child: Text(
              "Usuários cadastrados",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Center(
            child: Text(
              "Lista de usuários que foram cadastrados no sistema.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SearchTextField(
            hintText: "Buscar por Email",
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: _selectedRole,
                dropdownColor: Colors.grey[900],
                items: const [
                  DropdownMenuItem(
                    value: 'funcionario',
                    child: Text(
                      'Funcionários',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'cliente',
                    child: Text(
                      'Clientes',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildSortButton('ID', 'id', 1),
              _buildSortButton('Nome', 'name', 4),
              _buildSortButton('Email', 'email', 4),
              _buildSortButton('CPF', 'cpf', 3),
            ],
          ),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildUserColumn(List<Map<String, dynamic>> users) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap:
              true, // Permite que o ListView expanda com base em seu conteúdo
          physics:
              const NeverScrollableScrollPhysics(), // Desabilita o scroll do ListView interno
          itemCount: users.length,
          itemBuilder: (context, index) {
            final userData = users[index]['data'];
            return _buildUserCard(userData);
          },
        ),
      ],
    );
  }

  Widget _buildSortButton(String label, String field, int flex) {
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: () {
          setState(() {
            if (_sortBy == field) {
              _isAscending = !_isAscending;
            } else {
              _sortBy = field;
              _isAscending = true;
            }
          });
        },
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.white),
              textAlign: TextAlign.start,
            ),
            Icon(
              _sortBy == field
                  ? (_isAscending ? Icons.arrow_upward : Icons.arrow_downward)
                  : null,
              color: Colors.white,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(Map<String, dynamic> userData) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 50 : 15),
      child: Card(
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
                flex: 1,
                child: Text(
                  '${userData['id'] ?? 'ID não disponível'}',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  '${userData['name'] ?? 'Nome não disponível'}',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  '${userData['email'] ?? 'Email não disponível'}',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  '${userData['cpf'] ?? 'CPF não disponível'}',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
