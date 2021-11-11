import 'package:cached_network_image/cached_network_image.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class UserAvatar extends StatelessWidget {
  final User? user;
  final double radius;
  final VoidCallback? onTap;
  final Widget? defaultWidget;
  const UserAvatar(
      {Key? key,
      required this.user,
      this.defaultWidget,
      this.radius = 50,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap
      // ??
      //     () {
      //       // Get.toNamed(Profile)
      //     }
      ,
      child: CircleAvatar(
        radius: radius,
        child: user != null && user!.profilePicturePath != null
            ? CachedNetworkImage(
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageBuilder: (context, imageProvider) => Container(
                      width: radius * 2,
                      height: radius * 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                imageUrl: ApiService.host + "/" + user!.profilePicturePath!)
            : (defaultWidget ?? Icon(Icons.person, size: radius * 2)),
      ),
    );
  }
}
