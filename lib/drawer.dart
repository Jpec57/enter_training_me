import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/navigation/main_routing.dart';
import 'package:enter_training_me/navigation/navigation_element.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  static const listItemStyle =
      TextStyle(color: Colors.black87, fontStyle: FontStyle.italic);

  Widget _renderNavigatorElement(NavigationElement element) {
    return ListTile(
      leading: Icon(element.iconData),
      title: Text(
        element.title,
        style: listItemStyle,
      ),
      onTap: () {
        Get.toNamed(element.routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  'EnterTrainingMe',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              decoration: const BoxDecoration(
                color: CustomTheme.middleGreen,
              ),
            ),
            _renderNavigatorElement(MainRouting.homeNavigationElement),
            ...MainRouting.mainNavigationElements
                .map((element) => _renderNavigatorElement(element))
                .toList(),
          ],
        ),
      ),
    );
  }
}
