import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ExerciseHero extends StatelessWidget {
  final VoidCallback onTap;
  final int index;
  const ExerciseHero({Key? key, required this.index, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Hero(
        tag: "exo$index",
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white)),
              child: Row(
                children: [
                  SizedBox(
                    height: 70,
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
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Tractions",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
