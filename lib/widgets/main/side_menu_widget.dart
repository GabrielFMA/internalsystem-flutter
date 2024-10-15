import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/data/side_menu_data.dart';
import 'package:internalsystem/utils/navigation_utils.dart';
import 'package:internalsystem/components/search_textfield.dart'; // Importa o componente de busca
import 'package:shared_preferences/shared_preferences.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int selectedIndex = 0;
  String _searchQuery = ''; // Variável para armazenar a pesquisa
  List<Map<String, dynamic>> _filteredMenuOptions = [];

  @override
  void initState() {
    super.initState();
    _loadSelectedIndex();
    _filteredMenuOptions = SideMenuData().allMenuOptions;
  }

  Future<void> _loadSelectedIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedIndex = prefs.getInt('selectedIndex') ?? 0;
    });
  }

  void _filterMenuOptions(String query) {
    setState(() {
      _searchQuery = query;
      _filteredMenuOptions = SideMenuData().allMenuOptions.where((option) {
        return option['text']
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Container(
      color: menuColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
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
          const SizedBox(height: 15),

          // Usa o componente de pesquisa
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SearchTextField(
              onChanged: _filterMenuOptions, // Chama a função de filtro
            ),
          ),
          const SizedBox(height: 10),

          // Exibe as opções filtradas no menu
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _filteredMenuOptions.map((option) {
                  return buttonDefault(
                    text: option['text']!,
                    icon: option['icon']!,
                    route: option['route']!,
                    currentRoute: currentRoute,
                    onClick: () {
                      if (option['route'] != currentRoute) {
                        navigateTo(option['route']!, context);
                      }
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget buttonDefault({
    required String text,
    required IconData icon,
    required String route,
    required String? currentRoute,
    VoidCallback? onClick,
  }) {
    final isSelected = route == currentRoute;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: isSelected ? Colors.white : Colors.transparent,
            overlayColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: TextStyle(
              fontSize: 15,
              color: isSelected ? Colors.black : Colors.white,
            ),
          ),
          onPressed: onClick,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 5),
              Icon(icon,
                  color: isSelected ? Colors.black : Colors.white, size: 20),
              const SizedBox(width: 15),
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
