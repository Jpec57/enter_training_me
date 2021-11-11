import 'package:enter_training_me/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final String comment;
  final User author;

  const Comment({required this.comment, required this.author});
}
