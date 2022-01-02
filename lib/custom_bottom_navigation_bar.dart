import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/navigation/main_routing.dart';
import 'package:enter_training_me/navigation/navigation_element.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final String selectedRoute;
  static const _bottomNavigationBarColor = Colors.white;
  static const _bottomNavigationBarSelectedColor = CustomTheme.grey;

  const CustomBottomNavigationBar({Key? key, required this.selectedRoute})
      : super(key: key);

  static Widget getCenteredFloatingButton(BuildContext context,
      {bool isSelected = false}) {
    return FloatingActionButton(
        backgroundColor: CustomTheme.greenGrey,
        onPressed: () {
          context.go(MainRouting.homeNavigationElement.routeName);
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
      BuildContext context, NavigationElement element, bool isSelected) {
    return IconButton(
        icon: Icon(element.iconData),
        color: isSelected
            ? _bottomNavigationBarSelectedColor
            : _bottomNavigationBarColor,
        onPressed: () {
          context.go(element.routeName);
        });
  }

  List<Widget> _renderElements(String selectedRoute, BuildContext context) {
    List<Widget> elements = MainRouting.mainNavigationElements
        .map((element) => _renderBottomNavigationItem(
            context, element, element.routeName == selectedRoute))
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
        color: CustomTheme.greenGrey,
        shape: const CircularNotchedRectangle(),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _renderElements(selectedRoute, context)));
  }
}
