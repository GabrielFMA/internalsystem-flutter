import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:universal_html/js.dart';

class PermissionsWidget extends StatelessWidget {
  const PermissionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

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
  ];

  final List<bool> _isChecked = List.generate(5, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
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
    );
  }
}

Future<dynamic> showDialogPermissions(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: const Text('Selecione as Permissões')),
        backgroundColor: backgroundColor,
        content: Column(
          children: [
            Center(
                child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Fecha o diálogo
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      side: null),
                  child: const Text(
                    'Concluir permissões',
                    style: TextStyle(
                        color: backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Fecha o diálogo
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: backgroundColor,
                      padding: EdgeInsets.all(16),
                      side: null),
                  child: const Text(
                    'Concluir permissões',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Fecha o diálogo
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: backgroundColor,
                      padding: EdgeInsets.all(16),
                      side: null),
                  child: const Text(
                    'Concluir permissões',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ],
            )),
            SizedBox(
              height: 10,
            ),
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
                    vertical: 12, // Centraliza verticalmente o texto
                    horizontal: 15, // Adiciona margem do lado esquerdo do texto
                  ),
                ),
                style: const TextStyle(color: textFieldColor),
              ),
            ),
            SizedBox(height: 10),
            PermissionsCheckbox(),
          ],
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.white, padding: EdgeInsets.all(16)),
              child: const Text(
                'Concluir permissões',
                style: TextStyle(
                    color: backgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      );
    },
  );
}
