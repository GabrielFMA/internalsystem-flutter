import 'package:flutter/material.dart';
import 'package:internalsystem/const/const.dart';
import 'package:internalsystem/data/side_menu_data.dart';
import 'package:internalsystem/store/auth_store.dart';
import 'package:provider/provider.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final data = SideMenuData();

    return Container(
      color: menuColor,
      child: Column(
        children: [
          // Adicione qualquer widget acima dos botões aqui
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                Text(
                  "STORE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w100,
                    height: 0.8,
                  ),
                ),
                Text(
                  "CAR",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    height: 0.8,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 1,
          ),
          // Expanded para permitir que o ListView.builder use o espaço restante
          Expanded(
            child: ListView.builder(
              itemCount: data.menu.length,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              itemBuilder: (context, index) => buildMenuEntry(data, index),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              child: Text("Logout"),
              onPressed: () async {
                await Provider.of<AuthStore>(context, listen: false).logout();
                navigateTo('/login', context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuEntry(SideMenuData data, int index) {
    final isSelected = selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        color: isSelected ? selectionColor : Colors.transparent,
      ),
      child: InkWell(
        onTap: () => setState(() {
          selectedIndex = index;
        }),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              child: Icon(
                data.menu[index].icon,
                color: isSelected ? iconSelectionColor : Colors.white,
              ),
            ),
            Text(
              data.menu[index].title,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? iconSelectionColor : Colors.white,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
