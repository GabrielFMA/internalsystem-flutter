import 'package:internalsystem/widgets/register/register_widget.dart';
import 'package:internalsystem/widgets/users/users_widget.dart';

class PermissionsData {
  final List<Map<String, dynamic>> permissionsUsers = [
    {
      'title': 'Retirar o acesso de usuários ao Sistema Interno',
      'description': 'Dá o poder ao usuário de retirar o acesso de usuários do Sistema Interno',
      'permission': 'removeUserAcessWeb',
    },
    {
      'title': 'Restringe o acesso de usuários ao Sistema Interno',
      'description': 'Dá o poder ao usuário de Restringir o acesso de usuários do Sistema Interno',
      'permission': 'limitUserAcessWeb',
    },
    {
      'title': 'Restringe o acesso de usuários ao Aplicativo',
      'description': 'Dá o poder ao usuário de Restringir o acesso de usuários do Aplicativo',
      'permission': 'limitUserAcessApp',
    },
    {
      'title': 'Editar o email de usuários do Sistema Interno',
      'description': 'Dá o poder ao usuário de editar o emails de Usuários do Sistema Interno.',
      'permission': 'editUserEmailWeb',
    },
    {
      'title': 'Editar o email de usuários do Aplicativo',
      'description': 'Dá o poder ao usuário de editar o emails de Usuários do Aplicativo.',
      'permission': 'editUserEmailApp',
    }, 
  ];

  final List<Map<String, dynamic>> permissionsRoutes = [
    {
      'title': 'Entrar na tela de Usuários',
      'description': 'Dá acesso ao usuário o poder de entrar na tela Usuários.',
      'permission': 'enterUsersScreen',
      'screen': UsersWidget,
    },
    {
      'title': 'Entrar na tela de Registro',
      'description': 'Dá acesso ao usuário o poder de entrar na tela Register.',
      'permission': 'enterRegisterScreen',
      'screen': RegisterWidget,
    },
  ];

  final List<Map<String, dynamic>> permissionsAdmin = [
    {
      'title': 'Dá o acesso de usuários ao Sistema Interno',
      'description': 'Dá acesso ao usuário de entrar no Sistema Interno',
      'permission': 'isAdmin',
    },
  ];
}

