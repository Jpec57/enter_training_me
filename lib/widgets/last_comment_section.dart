import 'package:enter_training_me/widgets/cards/default_section_card.dart';
import 'package:flutter/material.dart';

class LastCommentSection extends StatelessWidget {
  final int commentCount;
  final String? lastComment;
  const LastCommentSection(
      {Key? key, required this.commentCount, this.lastComment})
      : super(key: key);

  Widget _renderLastComment() {
    TextStyle style = const TextStyle(fontStyle: FontStyle.italic);
    if (lastComment == null) {
      return Center(child: Text("No comment yet.", style: style));
    }
    return Column(
      children: [
        const Align(
            alignment: Alignment.topLeft,
            child:
                RotatedBox(quarterTurns: 2, child: Icon(Icons.format_quote))),
        Text(lastComment ?? "No comment",
            style: const TextStyle(fontStyle: FontStyle.italic)),
        const Align(
            alignment: Alignment.bottomRight, child: Icon(Icons.format_quote)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultSectionCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text("Comments ($commentCount)",
              style: Theme.of(context).textTheme.headline3),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: _renderLastComment(),
        ),
      ],
    ));
  }
}
