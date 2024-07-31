import 'package:flutter/material.dart';
import 'package:internalsystem/const/const.dart';
import 'package:internalsystem/util/responsive.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Responsive.isDesktop(context) ? Colors.transparent : menuColor,
      height: 62.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!Responsive.isDesktop(context))
            InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: const Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  Icons.menu,
                  color: Colors.grey,
                  size: 25,
                ),
              ),
            ),
          
        ],
      ),
    );
  }
}
