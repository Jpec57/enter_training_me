import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ExerciseViewPage extends StatelessWidget {
  static const routeName = "/exercise/view";

  const ExerciseViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: CachedNetworkImage(
                  imageUrl:
                  "https://www.muscleandfitness.com/wp-content/uploads/2018/06/pullup-1-1109.jpg?quality=86&strip=all",
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                ),
              )
          ),
          const Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
                child: SingleChildScrollView(
                  child: const Text("Saisissez la barre de tractions avec vos avant-bras tournés vers l'extérieur et les paumes vers l'intérieur. Engagez vos épaules en rapprochant vos omoplates et cherchez à vous hisser en gardant une direction la plus droite possible."),
                ),
              )
          ),
        ],
      ),
    );
  }
}
/*

 */