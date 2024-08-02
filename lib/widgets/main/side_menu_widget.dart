import 'package:flutter/material.dart';
import 'package:internalsystem/const/const.dart';
import 'package:internalsystem/data/side_menu_data.dart';
import 'package:internalsystem/store/auth_store.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSelectedIndex();
  }

  Future<void> _loadSelectedIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedIndex = prefs.getInt('selectedIndex') ?? 0;
    });
  }

  Future<void> _setSelectedIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedIndex = index;
      prefs.setInt('selectedIndex', index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = SideMenuData();

    return Container(
      color: menuColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 120,
                height: 120,
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 1,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.menu.length,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              itemBuilder: (context, index) => buildMenuEntry(data, index),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                onPressed: () async {
                  await Provider.of<AuthStore>(context, listen: false).logout();
                  Navigator.pushNamed(context, '/login');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 5),
                    Icon(MdiIcons.logout, color: Colors.white, size: 20),
                    SizedBox(width: 15), // Espaçamento entre o ícone e o texto
                    Text("Sair", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
            ),
          )
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
        onTap: () {
          _setSelectedIndex(index);
          Navigator.pushNamed(context, data.menu[index].route);
        },
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
