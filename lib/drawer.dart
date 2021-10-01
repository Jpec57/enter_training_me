import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/pages/1rm/one_rm_page.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/quick_countdown/quick_countdown_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Drawer Header',
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: CustomTheme.middleGreen,
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.person),
          //   title: Text('Profile'),
          //   onTap: () {
          //     Get.toNamed(ProfilePage.routeName);
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              'Home',
              style:
                  TextStyle(color: Colors.black87, fontStyle: FontStyle.italic),
            ),
            onTap: () {
              Get.toNamed(HomePage.routeName);
            },
          ),

          ListTile(
            leading: Icon(Icons.timer_sharp),
            title: Text(
              'Quick Countdown',
              style:
                  TextStyle(color: Colors.black87, fontStyle: FontStyle.italic),
            ),
            onTap: () {
              Get.toNamed(QuickCountdownPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.timer_sharp),
            title: Text(
              '1RM Calculator',
              style:
                  TextStyle(color: Colors.black87, fontStyle: FontStyle.italic),
            ),
            onTap: () {
              Get.toNamed(OneRMPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log out', style: TextStyle(color: Colors.black)),
            onTap: () {
              // BlocProvider.of<AuthBloc>(context).add(LoggedOut());
              // Get.toNamed(ProfilePage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
