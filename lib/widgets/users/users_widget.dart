import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/stores/request_store.dart';
import 'package:internalsystem/utils/responsive.dart';
import 'package:provider/provider.dart';

class UsersWidget extends StatefulWidget {
  const UsersWidget({super.key});

  @override
  State<UsersWidget> createState() => _UsersWidgetState();
}

class _UsersWidgetState extends State<UsersWidget> {
  late Future<List<Map<String, dynamic>>> _futureUsers;

  @override
  void initState() {
    super.initState();
    final store = Provider.of<RequestStore>(context, listen: false);
    _futureUsers = store.fetchData('users', information: ['name', 'email']);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Padding(
      padding: isDesktop
          ? const EdgeInsets.only(top: desktopHeader)
          : const EdgeInsets.only(top: mobileHeader),
      child: Scaffold(
        body: FutureBuilder<List<Map<String, dynamic>>>(
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

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          'Nome',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ),
                      SizedBox(width: 20),
                      SizedBox(
                        width: 200,
                        child: Text(
                          'Email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey,
                  height: 1),
                  ...users.map((user) {
                    final userData = user['data'];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            userData['name'] ?? 'Nome não disponível',
                            style: const TextStyle(fontSize: 19),
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 200,
                          child: Text(
                            userData['email'] ?? 'Email não disponível',
                            style: const TextStyle(fontSize: 19),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
