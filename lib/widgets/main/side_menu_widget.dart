import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/data/side_menu_data.dart';
import 'package:internalsystem/stores/auth_store.dart';
import 'package:internalsystem/utils/navigation_utils.dart';
import 'package:internalsystem/widgets/loading_screen.dart';
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
          SizedBox(height: 20),
          
          buttonDefault(
            text: 'Home',
            icon: MdiIcons.home,
            onClick: () {},
          ),
          buttonDefault(
            text: 'Account',
            icon: MdiIcons.account,
            onClick: () {},
          ),
          buttonDefault(
            text: 'Register',
            icon: MdiIcons.accountSupervisor,
            onClick: () {
              navigateTo("/register", context);
            },
          ),

          const Spacer(),

          buttonDefault(
            text: "Sair",
            icon: MdiIcons.logout,
            onClick: () async {
              await navigateToSomeBuilder(buildLoadingScreen(), context, 1000);
              await Provider.of<AuthStore>(context, listen: false).logout();
              Navigator.pushNamed(context, '/login');
            },
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget buttonDefault(
      {required String text, required IconData icon, VoidCallback? onClick}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
          onPressed: onClick,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 5),
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 15),
              Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
