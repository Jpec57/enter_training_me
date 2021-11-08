import 'package:cached_network_image/cached_network_image.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileHeader extends StatelessWidget {
  final User user;
  const ProfileHeader({Key? key, required this.user}) : super(key: key);

  Widget _renderQuickInfos(String title, String value) {
    return Column(
      children: [
        Text(title.toUpperCase(),
            style: const TextStyle(
                fontSize: 16,
                color: CustomTheme.green,
                fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(value),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      InkWell(
        onTap: () async{
          await RepositoryProvider.of<UserRepository>(context).changeProfilePic();
        },
        child: CircleAvatar(
          radius: 50,
          child: user.profilePicturePath != null
              ? CachedNetworkImage(imageUrl: user.profilePicturePath!)
              : const Icon(Icons.image, size: 40),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 24),
        child: Text(user.username,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 32),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           _renderQuickInfos("Level", "42"),
      //           _renderQuickInfos("SBD", "702kg"),
      //           _renderQuickInfos("Skill", "57"),
      //         ],
      //       ),
      //     ],
      //   ),
      // )
    ]);
  }
}
