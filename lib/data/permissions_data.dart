import 'package:internalsystem/widgets/register/register_widget.dart';
import 'package:internalsystem/widgets/users/user_widget.dart';

class PermissionsData {
  final List<Map<String, dynamic>> permissionsUsers = [
    {
      'title': 'Remover acesso Web',
      'description': 'Dá o poder ao usuário de retirar o acesso de usuários do Sistema Interno',
      'level': 3,
      'permission': 'removeUserAcessWeb',
    },
    {
      'title': 'Remover acesso App',
      'description': 'Dá o poder ao usuário de retirar o acesso de usuários do Aplicativo',
      'level': 3,
      'permission': 'removeUserAcessApp',
    },
    {
      'title': 'Editar email Web',
      'description': 'Dá o poder ao usuário de editar o emails de Usuários do Sistema Interno.',
      'level': 3,
      'permission': 'editUserEmailWeb',
    },
    {
      'title': 'Editar email App',
      'description': 'Dá o poder ao usuário de editar o emails de Usuários do Aplicativo.',
      'level': 3,
      'permission': 'editUserEmailApp',
    }, 
  ];

  final List<Map<String, dynamic>> permissionsRoutes = [
    {
      'title': 'Entrar tela Usuários',
      'description': 'Dá acesso ao usuário o poder de entrar na tela Usuários.',
      'permission': 'enterUsersScreen',
      'level': 1,
      'screen': UserWidget,
    },
    {
      'title': 'Entrar tela Registro',
      'description': 'Dá acesso ao usuário o poder de entrar na tela Register.',
      'permission': 'enterRegisterScreen',
      'level': 2,
      'screen': RegisterWidget,
    },
  ];

  final List<Map<String, dynamic>> permissionsAdmin = [
    {
      'title': 'Acessar Sistema Interno',
      'description': 'Dá acesso ao usuário de entrar no Sistema Interno',
      'level': 0,
      'permission': 'isAdmin',
    },
  ];
}

