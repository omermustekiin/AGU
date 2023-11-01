import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/utils.dart';
import 'follow_unfollow_button.dart';

class FollowerWidget extends StatelessWidget {
  String followeruserName;
  String btnText;
  FollowerWidget(
      {Key? key, required this.followeruserName, required this.btnText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(Utils.circleAvatarUrl),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  followeruserName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: FollowOrUnfollowButton(text: btnText),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          child: Divider(
            thickness: 1.5,
            color: mainColor,
          ),
        )
      ],
    );
  }
}
