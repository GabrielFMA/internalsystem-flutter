// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/utils/responsive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:internalsystem/data/permissions_data.dart';

class PopUpPermissionsWidget extends StatefulWidget {
  const PopUpPermissionsWidget({super.key});

  @override
  _PopUpPermissionsWidgetState createState() => _PopUpPermissionsWidgetState();
}

class _PopUpPermissionsWidgetState extends State<PopUpPermissionsWidget> {
  int _selectedButton = 1;
  String _searchQuery = '';

  final List<String> _permissionsUser = PermissionsData()
      .permissionsUsers
      .map((permission) => permission['title'] as String)
      .toList();

  final List<String> _permissionsRoutes = PermissionsData()
      .permissionsRoutes
      .map((permission) => permission['title'] as String)
      .toList();

  final List<String> _permissionsAdmin = PermissionsData()
      .permissionsAdmin
      .map((permission) => permission['title'] as String)
      .toList();

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
    final isMobile = Responsive.isDesktop(context);
    String admin = isMobile ? "Administrativo" : "Admin";

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPermissionButton(context, 1, "Usuários"),
                  SizedBox(width: isMobile ? 20 : 5),
                  _buildPermissionButton(context, 2, "Rotas"),
                  SizedBox(width: isMobile ? 20 : 5),
                  _buildPermissionButton(context, 3, admin),
                ],
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 17.5, right: 15),
                  child: Icon(
                    MdiIcons.magnify,
                    size: 19.5,
                    color: Colors.white,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: textFieldColor, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: textFieldColor, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white38, width: 1.5),
                ),
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 15,
                ),
              ),
              style: const TextStyle(color: textFieldColor),
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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            // Display checkboxes based on selected filter
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
    List<String> permissions;
    Map<String, bool> permissionsStatus;

    if (selectedFilter == 'Usuários') {
      permissions = _permissionsUser;
      permissionsStatus = _permissionsUserStatus;
    } else if (selectedFilter == 'Rotas') {
      permissions = _permissionsRoutes;
      permissionsStatus = _permissionsRoutesStatus;
    } else {
      permissions = _permissionsAdmin;
      permissionsStatus = _permissionsAdminStatus;
    }

    final filteredPermissions = permissions.where((permission) {
      return permission.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: filteredPermissions.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          title: Text(filteredPermissions[index]),
          value: permissionsStatus[filteredPermissions[index]] ?? false,
          onChanged: (value) {
            setState(() {
              permissionsStatus[filteredPermissions[index]] = value!;
            });
          },
          activeColor: Colors.white,
        );
      },
    );
  }

  Widget _buildPermissionButton(BuildContext context, int buttonIndex, String text) {
    final isMobile = Responsive.isDesktop(context);
    final bool isSelected = _selectedButton == buttonIndex;

    return TextButton(
      onPressed: () {
        _onButtonPressed(buttonIndex);
      },
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.white : backgroundColor,
        padding: const EdgeInsets.all(16),
        fixedSize: Size(isMobile ? 152 : 117, 44),
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white, width: 1.5),
      ),
      child: Center(
        child: Text(
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

      final matchedPermissions = selectedPermissions.map((selectedTitle) {
        return permissionMap[selectedTitle];
      }).where((permission) => permission != null).toList();

      print('Permissões correspondentes: $matchedPermissions');
    }
  });
}
