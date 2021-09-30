import 'package:enter_training_me/drawer.dart';
import 'package:enter_training_me/pages/in_workout/in_workout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/home";
  final kHeaderPercentSize = 0.40;
  final kHeaderOverlappingSize = 0.05;
  final kHeaderContainerSize = 0.2;
  static const bottomBackgroundContainerColor = Colors.black;
  final topBackgroundContainerColor = Colors.grey;

  const HomePage({Key? key}) : super(key: key);

  Widget _renderListView() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: TrainingProposalContainer(),
        );
      },
    );
  }

  List<Widget> _renderBackground(BuildContext context, double height) {
    return [
      SizedBox(
          height: height * kHeaderPercentSize,
          child: Container(
            color: Colors.grey,
          )),
      Positioned(
        bottom: 0,
        child: SizedBox(
            height: height * kHeaderOverlappingSize.toDouble(),
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: const BoxDecoration(
                  color: bottomBackgroundContainerColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
            )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      drawer: const MyDrawer(),
      backgroundColor: topBackgroundContainerColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * (kHeaderPercentSize + kHeaderOverlappingSize),
              child: Stack(children: [
                ..._renderBackground(context, height),
                Positioned(
                    top: height * (kHeaderPercentSize - kHeaderContainerSize),
                    child: SizedBox(
                      height: height *
                          (kHeaderContainerSize + kHeaderOverlappingSize)
                              .toDouble(),
                      width: MediaQuery.of(context).size.width,
                      child: _renderListView(),
                    )),
              ]),
            ),
            Container(
              color: bottomBackgroundContainerColor,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 50,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(
                        "Toto is here $i",
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class TrainingProposalContainer extends StatelessWidget {
  const TrainingProposalContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(InWorkoutPage.routeName);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
            border: Border.all(color: Colors.black87, width: 1)),
        height: 180,
        width: 180,
        padding: const EdgeInsets.all(24),
        child: const Text("Coucou", style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
