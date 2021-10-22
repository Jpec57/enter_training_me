import 'package:enter_training_me/models/models.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final User user;
  const ProfileHeader({Key? key, required this.user}) : super(key: key);

  Widget _renderQuickInfos() {
    return Column(
      children: [
        Text("Level".toUpperCase(),
            style: TextStyle(
                fontSize: 16,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold)),
        Text("32")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const CircleAvatar(
        radius: 50,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 24),
        child: Text(user.username,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _renderQuickInfos(),
                _renderQuickInfos(),
                _renderQuickInfos()
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
