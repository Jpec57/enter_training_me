import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/navigation/main_routing.dart';
import 'package:enter_training_me/navigation/navigation_element.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  static const _bottomNavigationBarColor = Colors.white;

  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  static Widget getCenteredFloatingButton() {
    return FloatingActionButton(
        backgroundColor: CustomTheme.middleGreen,
        onPressed: MainRouting.homeNavigationElement.onPressed,
        tooltip: MainRouting.homeNavigationElement.title,
        child: Icon(
          MainRouting.homeNavigationElement.iconData,
          color: _bottomNavigationBarColor,
        ));
  }

  Widget _renderBottomNavigationItem(NavigationElement element) {
    return IconButton(
        icon: Icon(element.iconData),
        color: _bottomNavigationBarColor,
        onPressed: () {
          Get.toNamed(element.routeName);
        });
  }

  List<Widget> _renderElements() {
    List<Widget> elements = MainRouting.mainNavigationElements
        .map((element) => _renderBottomNavigationItem(element))
        .toList();
    int len = elements.length;
    if (len % 2 == 0) {
      elements = [
        ...elements.sublist(0, len ~/ 2),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home, color: Colors.transparent)),
        ...elements.sublist(len ~/ 2, len)
      ];
    }
    return elements;
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: CustomTheme.middleGreen,
        shape: const CircularNotchedRectangle(),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _renderElements()));
  }
}