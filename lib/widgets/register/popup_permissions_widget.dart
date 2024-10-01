import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/utils/responsive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PermissionsCheckbox extends StatefulWidget {
  @override
  _PermissionsCheckboxState createState() => _PermissionsCheckboxState();
}

class _PermissionsCheckboxState extends State<PermissionsCheckbox> {
  final List<String> _permissions = [
    'Permissão 1',
    'Permissão 2',
    'Permissão 3',
    'Permissão 4',
    'Permissão 5',
    'Permissão 6',
    'Permissão 7',
    'Permissão 8',
    'Permissão 6',
    'Permissão 6',
    'Permissão 6',
    'Permissão 6',
    'Permissão 6',
    'Permissão 6',
    'Permissão 6',
    'Permissão 6',
    'Permissão 6',
    'Permissão 6',
  ];

  final List<bool> _isChecked = List.generate(99, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height:
          600, // NAO ESQUECER DE ALTERAR ISTO AQUI PARA RECEBER O TAMANHO DA TELA E SSE MEXER DE ACORDo
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_permissions.length, (index) {
            return CheckboxListTile(
              activeColor: Colors.white,
              title: Text(_permissions[index]),
              value: _isChecked[index],
              onChanged: (bool? value) {
                setState(() {
                  _isChecked[index] = value ?? false;
                });
              },
            );
          }),
        ),
      ),
    );
  }
}

class PopUpPermissionsWidget extends StatefulWidget {
  @override
  _PopUpPermissionsWidgetState createState() => _PopUpPermissionsWidgetState();
}

class _PopUpPermissionsWidgetState extends State<PopUpPermissionsWidget> {
  int _selectedButton = 1; // Define qual botão está selecionado

  void _onButtonPressed(int buttonIndex) {
    setState(() {
      _selectedButton = buttonIndex; // Atualiza o botão selecionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: const Text('Selecione as Permissões')),
      backgroundColor: backgroundColor,
      content: Container(
        width: 450, // Define a largura da AlertDialog para 400
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPermissionButton(context, 1, "Usuários"),
                  SizedBox(width: 5),
                  _buildPermissionButton(context, 2, "Rotas"),
                  SizedBox(width: 5),
                  _buildPermissionButton(context, 3, "Administrativo"),
                ],
              ),
            ),
            SizedBox(height: 10),
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
                    borderSide:
                        const BorderSide(color: textFieldColor, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: textFieldColor, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.white38, width: 2),
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
            SizedBox(height: 10),
            PermissionsCheckbox(),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.all(16),
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

  Widget _buildPermissionButton(
      BuildContext context, int buttonIndex, String text) {
    final bool isSelected = _selectedButton == buttonIndex;
    return TextButton(
      onPressed: () {
        _onButtonPressed(buttonIndex);
      },
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.white : backgroundColor,
        padding: EdgeInsets.all(16),
        fixedSize: Size(140, 40),
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

Future<dynamic> showDialogPermissions(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return PopUpPermissionsWidget();
    },
  );
}
