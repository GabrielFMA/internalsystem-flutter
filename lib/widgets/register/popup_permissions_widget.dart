import 'package:flutter/material.dart';
import 'package:internalsystem/components/search_textfield.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/models/register_model.dart';
import 'package:internalsystem/utils/responsive.dart';
import 'package:internalsystem/data/permissions_data.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PopUpPermissionsWidget extends StatefulWidget {
  final RegisterModel registerModel;

  const PopUpPermissionsWidget(this.registerModel, {super.key});

  @override
  _PopUpPermissionsWidgetState createState() => _PopUpPermissionsWidgetState();
}

final Map<String, bool> globalPermissionsUserStatus = {};
final Map<String, bool> globalPermissionsRoutesStatus = {};
final Map<String, bool> globalPermissionsAdminStatus = {};
Map<String, bool> mapPermissions = {};

class _PopUpPermissionsWidgetState extends State<PopUpPermissionsWidget> {
  int _selectedButton = 1;
  String _searchQuery = '';

  void _initializePermissionsStatus() {
    final allPermissions = {
      'Usuários': globalPermissionsUserStatus,
      'Rotas': globalPermissionsRoutesStatus,
      'Administrativo': globalPermissionsAdminStatus,
    };

    for (var entry in allPermissions.entries) {
      List<Map<String, dynamic>> permissionsList;

      switch (entry.key) {
        case 'Usuários':
          permissionsList = PermissionsData().permissionsUsers;
          break;
        case 'Rotas':
          permissionsList = PermissionsData().permissionsRoutes;
          break;
        default:
          permissionsList = PermissionsData().permissionsAdmin;
      }

      for (var permission in permissionsList) {
        entry.value.putIfAbsent(permission['title'], () => false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _initializePermissionsStatus();
  }

  void _onButtonPressed(int buttonIndex) {
    setState(() {
      _selectedButton = buttonIndex;
    });
  }

  void _printSelectedPermissions() {
    final allPermissions = {
      'Usuários': globalPermissionsUserStatus,
      'Rotas': globalPermissionsRoutesStatus,
      'Administrativo': globalPermissionsAdminStatus,
    };

    final selectedPermissions = [];

    allPermissions.forEach((category, permissionsStatus) {
      permissionsStatus.forEach((permissionTitle, isSelected) {
        if (isSelected) {
          // Encontrar a permissão específica em PermissionsData
          final permissionDetail =
              PermissionsData().getPermissionByTitle(category, permissionTitle);
          if (permissionDetail != null) {
            selectedPermissions.add(permissionDetail['permission']);
          }
        }
      });
    });

    widget.registerModel.permissions = Map.fromIterable(
      selectedPermissions,
      value: (item) => true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              _printSelectedPermissions();
              Navigator.of(context).pop();
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
      permissionsStatus = globalPermissionsUserStatus;
    } else if (selectedFilter == 'Rotas') {
      permissions = PermissionsData().permissionsRoutes;
      permissionsStatus = globalPermissionsRoutesStatus;
    } else {
      permissions = PermissionsData().permissionsAdmin;
      permissionsStatus = globalPermissionsAdminStatus;
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
          contentPadding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 10.0),
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
    final isMobile = Responsive.isMobile(context);
    final bool isSelected = _selectedButton == buttonIndex;

    return TextButton(
      onPressed: () {
        _onButtonPressed(buttonIndex);
      },
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.white : backgroundColor,
        padding: const EdgeInsets.all(16),
        fixedSize: Size(isMobile ? double.infinity : 117, 44),
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white, width: 1.5),
      ),
      child: Center(
        child: isMobile
            ? Icon(
                icon,
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

void showDialogPermissions(RegisterModel registerModel, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return PopUpPermissionsWidget(registerModel);
    },
  );
}
