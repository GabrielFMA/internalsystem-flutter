import 'package:flutter/material.dart';
import 'package:internalsystem/components/search_textfield.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/utils/responsive.dart';
import 'package:internalsystem/data/permissions_data.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PopUpPermissionsWidget extends StatefulWidget {
  const PopUpPermissionsWidget({super.key});

  @override
  _PopUpPermissionsWidgetState createState() => _PopUpPermissionsWidgetState();
}

class _PopUpPermissionsWidgetState extends State<PopUpPermissionsWidget> {
  int _selectedButton = 1;
  String _searchQuery = '';

  final Map<String, bool> _permissionsUserStatus = {};
  final Map<String, bool> _permissionsRoutesStatus = {};
  final Map<String, bool> _permissionsAdminStatus = {};

  void _onButtonPressed(int buttonIndex) {
    setState(() {
      _selectedButton = buttonIndex;
    });
  }

  List<String> _getAllSelectedPermissions() {
    List<String> selectedPermissions = [];

    _permissionsUserStatus.forEach((permission, isSelected) {
      if (isSelected) {
        selectedPermissions.add(permission);
      }
    });

    _permissionsRoutesStatus.forEach((permission, isSelected) {
      if (isSelected) {
        selectedPermissions.add(permission);
      }
    });

    _permissionsAdminStatus.forEach((permission, isSelected) {
      if (isSelected) {
        selectedPermissions.add(permission);
      }
    });

    return selectedPermissions;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context); // Verifica se é mobile
    String admin = isMobile ? "Admin" : "Administrativo";

    String selectedFilterText;
    if (_selectedButton == 1) {
      selectedFilterText = 'Usuários';
    } else if (_selectedButton == 2) {
      selectedFilterText = 'Rotas';
    } else {
      selectedFilterText = admin;
    }

    return AlertDialog(
      title: const Center(child: Text('Selecione as Permissões')),
      backgroundColor: backgroundColor,
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Para espaçar os botões
                children: [
                  Expanded(
                    child: _buildPermissionButton(
                        context, 1, "Usuários", MdiIcons.accountMultiple),
                  ),
                  SizedBox(width: isMobile ? 20 : 5),
                  Expanded(
                    child: _buildPermissionButton(
                        context, 2, "Rotas", MdiIcons.arrowDecision),
                  ),
                  SizedBox(width: isMobile ? 20 : 5),
                  Expanded(
                    child: _buildPermissionButton(
                        context, 3, admin, MdiIcons.security),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SearchTextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Selecione as permissões de "$selectedFilterText"',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: _buildPermissionsList(selectedFilterText),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop(_getAllSelectedPermissions());
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
              fixedSize: const Size(200, 44),
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white, width: 1.5),
            ),
            child: const Text(
              'Concluir permissões',
              style: TextStyle(
                color: backgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPermissionsList(String selectedFilter) {
    final isMobile = Responsive.isMobile(context);
    List<Map<String, dynamic>> permissions;
    Map<String, bool> permissionsStatus;

    if (selectedFilter == 'Usuários') {
      permissions = PermissionsData().permissionsUsers;
      permissionsStatus = _permissionsUserStatus;
    } else if (selectedFilter == 'Rotas') {
      permissions = PermissionsData().permissionsRoutes;
      permissionsStatus = _permissionsRoutesStatus;
    } else {
      permissions = PermissionsData().permissionsAdmin;
      permissionsStatus = _permissionsAdminStatus;
    }

    final filteredPermissions = permissions.where((permission) {
      return permission['title']
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: filteredPermissions.length,
      itemBuilder: (context, index) {
        final permission = filteredPermissions[index];
        final permissionTitle = permission['title'];
        final permissionLevel = permission['level'];

        return CheckboxListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: isMobile ? 0 : 10.0),
          title: Row(
            children: [
              Icon(
                MdiIcons.alertBox,
                color: colorIcon(permissionLevel),
                size: 26,
              ),
              SizedBox(width: isMobile ? 0 : 10.0),
              Text(permissionTitle),
            ],
          ),
          value: permissionsStatus[permissionTitle] ?? false,
          onChanged: (value) {
            setState(() {
              permissionsStatus[permissionTitle] = value!;
            });
          },
          activeColor: Colors.white,
        );
      },
    );
  }

  Widget _buildPermissionButton(
      BuildContext context, int buttonIndex, String text, IconData icon) {
    final isMobile = Responsive.isMobile(context); // Verifica se está em mobile
    final bool isSelected = _selectedButton == buttonIndex;

    return TextButton(
      onPressed: () {
        _onButtonPressed(buttonIndex);
      },
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.white : backgroundColor,
        padding: const EdgeInsets.all(16),
        fixedSize:
            Size(isMobile ? double.infinity : 117, 44), // Tamanho responsivo
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white, width: 1.5),
      ),
      child: Center(
        child: isMobile
            ? Icon(
                icon, // Exibe o ícone se for mobile
                color: isSelected ? backgroundColor : Colors.white,
                size: 24,
              )
            : Text(
                text,
                style: TextStyle(
                  color: isSelected ? backgroundColor : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}

void showDialogPermissions(BuildContext context) {
  showDialog<List<String>>(
    context: context,
    builder: (BuildContext context) {
      return const PopUpPermissionsWidget();
    },
  ).then((selectedPermissions) {
    if (selectedPermissions != null) {
      final allPermissions = [
        ...PermissionsData().permissionsUsers,
        ...PermissionsData().permissionsRoutes,
        ...PermissionsData().permissionsAdmin,
      ];

      final permissionMap = {
        for (var permission in allPermissions)
          permission['title']: permission['permission'],
      };

      final matchedPermissions = selectedPermissions
          .map((selectedTitle) {
            return permissionMap[selectedTitle];
          })
          .where((permission) => permission != null)
          .toList();

      print('Permissões correspondentes: $matchedPermissions');
    }
  });
}
