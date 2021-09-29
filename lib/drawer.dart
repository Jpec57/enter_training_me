import 'package:enter_training_me/custom_theme.dart';
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
            child: Text('Drawer Header', style: TextStyle(color: Colors.white),),
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
            leading: Icon(Icons.timer_sharp),
            title: Text('Quick Countdown'),
            onTap: () {
              Get.toNamed(QuickCountdownPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log out'),
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