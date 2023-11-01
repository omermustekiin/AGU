import 'package:flutter/material.dart';

class FollowOrUnfollowButton extends StatelessWidget {
  String text;
  FollowOrUnfollowButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: Text(text));
  }
}
