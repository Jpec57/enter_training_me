import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/navigation/main_routing.dart';
import 'package:enter_training_me/navigation/navigation_element.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final String selectedRoute;
  static const _bottomNavigationBarColor = Colors.white;
  static const _bottomNavigationBarSelectedColor = CustomTheme.grey;

  const CustomBottomNavigationBar({Key? key, required this.selectedRoute})
      : super(key: key);

  static Widget getCenteredFloatingButton({bool isSelected = false}) {
    return FloatingActionButton(
        backgroundColor: CustomTheme.middleGreen,
        onPressed: () {
          Get.offNamedUntil(MainRouting.homeNavigationElement.routeName,
              ModalRoute.withName(HomePage.routeName));
        },
        tooltip: MainRouting.homeNavigationElement.title,
        child: Icon(
          MainRouting.homeNavigationElement.iconData,
          color: isSelected
              ? _bottomNavigationBarSelectedColor
              : _bottomNavigationBarColor,
        ));
  }

  Widget _renderBottomNavigationItem(
      NavigationElement element, bool isSelected) {
    return IconButton(
        icon: Icon(element.iconData),
        color: isSelected
            ? _bottomNavigationBarSelectedColor
            : _bottomNavigationBarColor,
        onPressed: () {
          Get.offNamedUntil(
              element.routeName, ModalRoute.withName(HomePage.routeName));
        });
  }

  List<Widget> _renderElements(String selectedRoute) {
    List<Widget> elements = MainRouting.mainNavigationElements
        .map((element) => _renderBottomNavigationItem(
            element, element.routeName == selectedRoute))
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
            children: _renderElements(selectedRoute)));
  }
}
