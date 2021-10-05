import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/pages/1rm/one_rm_page.dart';
import 'package:enter_training_me/pages/home/home_page.dart';
import 'package:enter_training_me/pages/profile/profile_page.dart';
import 'package:enter_training_me/pages/quick_countdown/quick_countdown_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  static const listItemStyle =
      TextStyle(color: Colors.black87, fontStyle: FontStyle.italic);

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
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Home',
                style: listItemStyle,
              ),
              onTap: () {
                Get.toNamed(HomePage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'Profile',
                style: listItemStyle,
              ),
              onTap: () {
                Get.toNamed(ProfilePage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.timer_sharp),
              title: const Text(
                'Quick Countdown',
                style: listItemStyle,
              ),
              onTap: () {
                Get.toNamed(QuickCountdownPage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text(
                '1RM Calculator',
                style: listItemStyle,
              ),
              onTap: () {
                Get.toNamed(OneRMPage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title:
                  const Text('Log out', style: TextStyle(color: Colors.black)),
              onTap: () {
                // BlocProvider.of<AuthBloc>(context).add(LoggedOut());
                // Get.toNamed(ProfilePage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
