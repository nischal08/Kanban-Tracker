import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kanban/core/styles/text_styles.dart';
import 'package:kanban/presentation/models/comment_model.dart';

class CommentInfoWidget extends StatelessWidget {
  final CommentModel comment;
  const CommentInfoWidget(this.comment, {super.key});
  @override
  Widget build(BuildContext context) {
    String postedAt =
        "${DateFormat().add_MMMEd().format(comment.postedAt)}, ${DateFormat().addPattern("hh:mm a").format(comment.postedAt)}";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          comment.content,
          style: generalTextStyle(14).copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          postedAt,
          textAlign: TextAlign.end,
          style: generalTextStyle(11).copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
