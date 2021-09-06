import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var topContainerHeight = height * 0.35;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.35 + 30,
              child: Container(
                // color: Colors.black,
                child: Stack(
                  children: [
                    SizedBox(
                        height: topContainerHeight,
                        child: Container(
                          color: Colors.grey,
                        )
                    ),
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))
                            ),
                          )
                      ),
                    ),
                    Positioned(
                        top: height * 0.35 - 150,
                        child: SizedBox(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: TrainingProposalContainer(),
                            );
                          },

                          ),
                        )
                    ),
                  ]
                ),
              ),
            ),
            Container(
              color: Colors.black,
              child: ListView.builder(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 50,
                  itemBuilder: (context, i){
                return ListTile(
                  title: Text("Toto is here $i", style: TextStyle(color:Colors.white),),
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
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        border: Border.all(color: Colors.black87, width: 1)
      ),
      height: 180,
      width: 180,
      padding: const EdgeInsets.all(24),
      child: Text("Coucou", style: TextStyle(color: Colors.black)),
    );
  }
}
