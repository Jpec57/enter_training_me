import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/interfaces/api_service.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileHeader extends StatefulWidget {
  final User user;
  const ProfileHeader({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

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
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.image,
          );

          if (result != null) {
            File file = File(result.files.single.path!);
            User? user = await RepositoryProvider.of<UserRepository>(context)
                .changeProfilePic(file);
            if (user != null) {
              setState(() {
                _user = user;
              });
            }
          }
        },
        child: CircleAvatar(
          radius: 50,
          child: widget.user.profilePicturePath != null
              ? CachedNetworkImage(
                  imageUrl: ApiService.host + "/" + _user.profilePicturePath!)
              : const Icon(Icons.image, size: 40),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 24),
        child: Text(widget.user.username,
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
