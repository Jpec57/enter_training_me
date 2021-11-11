import 'dart:io';
import 'package:enter_training_me/custom_theme.dart';
import 'package:enter_training_me/models/models.dart';
import 'package:enter_training_me/services/repositories/user_repository.dart';
import 'package:enter_training_me/widgets/user/user_avatar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';

class ProfileHeader extends StatefulWidget {
  final User user;
  final bool isCurrentUser;

  const ProfileHeader(
      {Key? key, required this.user, this.isCurrentUser = false})
      : super(key: key);

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
      UserAvatar(
          user: _user,
          onTap: widget.isCurrentUser
              ? () async {
                  XFile? result = await (ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      maxHeight: 480,
                      maxWidth: 640));

                  if (result != null) {
                    File file = File(result.path);
                    bool isSuccess =
                        await RepositoryProvider.of<UserRepository>(context)
                            .changeProfilePic(file);
                    if (isSuccess) {
                      DefaultCacheManager manager = DefaultCacheManager();
                      manager.emptyCache(); //clears all data in cache.
                      setState(() {});
                    }
                  }
                }
              : null),
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
