import 'package:flutter/material.dart';

import '../constants/colors.dart';

class NotificationWidget extends StatelessWidget {
  String notifMessage;
  int notifTime;
  NotificationWidget(
      {Key? key, required this.notifMessage, required this.notifTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/ben.webp"),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notifMessage,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  "${notifTime.toString()} dakika önce",
                  style: const TextStyle(fontSize: 12),
                )
              ],
            )
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
