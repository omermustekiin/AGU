import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/utils.dart';

class CommentWidget extends StatefulWidget {
  String userName;
  String commentText;
  CommentWidget({Key? key, required this.userName, required this.commentText})
      : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(Utils.circleAvatarUrl),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.userName,
                  style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.commentText.length > 100
                      ? widget.commentText.substring(0, 100)
                      : widget.commentText,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                widget.commentText.length > 100
                    ? GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              content: Text(
                                widget.commentText,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Kapat',
                                    style: TextStyle(color: mainColor),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Text(
                              "Devamını Oku...",
                              style: TextStyle(
                                color: mainColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ))
                    : Container()
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }
}
