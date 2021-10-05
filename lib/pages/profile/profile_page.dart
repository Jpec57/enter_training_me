import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "/profile";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final kBottomContainerRadius = 50.0;
  late ScrollController _bottomContainerScrollController;

  @override
  void initState() {
    super.initState();
    _bottomContainerScrollController = ScrollController();
    _bottomContainerScrollController.addListener(() {
      // _bottomContainerScrollController.
    });
  }

  @override
  void dispose() {
    _bottomContainerScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: CustomTheme.darkGrey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: MediaQuery.of(context).size.height * 0.25,
            child: Stack(
              children: [
                Container(
                  color: Colors.lime,
                ),
                SafeArea(
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: const Icon(Icons.person),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("Jpec57"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: CustomTheme.middleGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kBottomContainerRadius),
                    topRight: Radius.circular(kBottomContainerRadius),
                  )),
              child: SingleChildScrollView(
                controller: _bottomContainerScrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("Tile $index"),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}