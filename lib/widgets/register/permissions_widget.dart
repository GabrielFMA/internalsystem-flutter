import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';
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
    return Column(
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
    );
  }
}

Future<dynamic> showDialogPermissions(BuildContext context){
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecione as Permissões'),
          backgroundColor: backgroundColor,
          content: PermissionsCheckbox(),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                },
                style: TextButton.styleFrom(backgroundColor: Colors.white, padding: EdgeInsets.all(16)),
                child: const Text('Concluir permissões', style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold, fontSize: 16),),
              ),
            ),
          ],
        );
      },
    );
}
