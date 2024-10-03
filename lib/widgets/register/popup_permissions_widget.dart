import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/utils/responsive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PopUpPermissionsWidget extends StatefulWidget {
  @override
  _PopUpPermissionsWidgetState createState() => _PopUpPermissionsWidgetState();
}

class _PopUpPermissionsWidgetState extends State<PopUpPermissionsWidget> {
  int _selectedButton = 1;

  final List<String> _permissionsUser = [
    'Permissão Usuário 1',
    'Permissão Usuário 2',
    'Permissão Usuário 3',
    'Permissão Usuário 4',
    'Permissão Usuário 5',
    'Permissão Usuário 6',
    'Permissão Usuário 7',
    'Permissão Usuário 8',
  ];

  final List<String> _permissionsRoutes = [
    'Permissão de Rota 1',
    'Permissão de Rota 2',
    'Permissão de Rota 3',
    'Permissão de Rota 4',
    'Permissão de Rota 5',
    'Permissão de Rota 6',
    'Permissão de Rota 7',
    'Permissão de Rota 8',
  ];

  final List<String> _permissionsAdmin = [
    'Permissão Admin 1',
    'Permissão Admin 2',
    'Permissão Admin 3',
    'Permissão Admin 4',
    'Permissão Admin 5',
    'Permissão Admin 6',
    'Permissão Admin 7',
    'Permissão Admin 8',
  ];

  // Controla o estado dos checkboxes
  Map<String, bool> _permissionsUserStatus = {};
  Map<String, bool> _permissionsRoutesStatus = {};
  Map<String, bool> _permissionsAdminStatus = {};

  void _onButtonPressed(int buttonIndex) {
    setState(() {
      _selectedButton = buttonIndex;
    });
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
      title: Center(child: const Text('Selecione as Permissões')),
      backgroundColor: backgroundColor,
      content: Container(
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
            SizedBox(height: 15),
            Container(
              height: 44,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 17.5, right: 15),
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
              ),
            ),
            SizedBox(height: 15),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Selecione as permissões de "$selectedFilterText"',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 15),
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
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.all(16),
              fixedSize: Size(200, 44),
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white, width: 1.5),
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

  // Função para construir a lista de checkboxes
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

    return ListView.builder(
      itemCount: permissions.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          title: Text(permissions[index]),
          value: permissionsStatus[permissions[index]] ?? false,
          onChanged: (value) {
            setState(() {
              permissionsStatus[permissions[index]] = value!;
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
        padding: EdgeInsets.all(16),
        fixedSize: Size(isMobile ? 152 : 117, 44),
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.white, width: 1.5),
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
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return PopUpPermissionsWidget();
    },
  );
}
