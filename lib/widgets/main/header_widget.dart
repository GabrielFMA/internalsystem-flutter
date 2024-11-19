import 'package:flutter/material.dart';
import 'package:internalsystem/constants/constants.dart';
import 'package:internalsystem/store/auth_store.dart';
import 'package:internalsystem/utils/navigation_utils.dart';
import 'package:internalsystem/utils/responsive.dart';
import 'package:internalsystem/widgets/main/loading_screen.dart';
import 'package:internalsystem/widgets/popup/popup_confirm.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      color: menuColor,
      height: isDesktop ? desktopHeader : mobileHeader,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isDesktop)
            InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(
                  Icons.menu,
                  color: iconHeaderColor,
                  size: 25,
                ),
              ),
            ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: PopupMenuButton<String>(
              icon: Icon(
                MdiIcons.account,
                color: iconHeaderColor,
                size: 25,
              ),
              onSelected: (value) {
                print('Selecionado: $value');
              },
              itemBuilder: (context) => [
                //BOTAO MINHA CONTA
                PopupMenuItem(
                  value: "account",
                  height: 40,
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Icon(MdiIcons.account, size: 18),
                      const SizedBox(width: 15),
                      const Text(
                        "Minha Conta",
                        style: TextStyle(
                            fontSize: 15.5, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),

                //BOTAO CONFIGURAÇÔES
                PopupMenuItem(
                  value: "config",
                  height: 40,
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Icon(MdiIcons.cog, size: 18),
                      const SizedBox(width: 15),
                      const Text(
                        "Configurações",
                        style: TextStyle(
                            fontSize: 15.5, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  onTap: () async {
                    navigateTo("/settings", context);
                  },
                ),

                //BOTAO SAIR
                PopupMenuItem(
                  value: "leave",
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PopUpConfirm(
                            () async {
                              await navigateToSomeBuilder(
                                  buildLoadingScreen(), context, 1000);
                              await Provider.of<AuthStore>(context,
                                      listen: false)
                                  .logout(context);
                              await Navigator.pushNamed(context, '/login');
                            },
                            'Sair',
                            'Deseja sair do sistema?',
                            'Sim',
                            'Não',
                          );
                        });
                  },
                  height: 40,
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Icon(MdiIcons.logout, size: 18),
                      const SizedBox(width: 15),
                      const Text(
                        "Sair",
                        style: TextStyle(
                            fontSize: 15.5, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: menuColor,
              padding: const EdgeInsets.all(8),
              elevation: 8,
            ),
          ),
        ],
      ),
    );
  }
}
