import 'package:enter_training_me/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class LogPage extends StatelessWidget {
  static const routeName = "/log";

  const LogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardDown = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      floatingActionButton: isKeyboardDown
          ? CustomBottomNavigationBar.getCenteredFloatingButton()
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavigationBar(
        selectedRoute: LogPage.routeName,
      ),
      body: SafeArea(
        child: Container(
          child: Text("Log"),
        ),
      ),
    );
  }
}
