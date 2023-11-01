import 'package:agufrontend/resources/user_information_methods.dart';
import 'package:agufrontend/screens/notifications.dart';
import 'package:agufrontend/widgets/search_bar.dart';
import 'package:flutter/material.dart';

import '../constants/utils.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //  Uint8List bytes = UserInfoMethods.user.avatar.buffer.asUint8List();
    return AppBar(
      backgroundColor: Colors.deepPurple[800],
      actions: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 1,
              ),
              Row(
                children: [
                  SizedBox(
                      height: 28,
                      child: Image.asset("assets/images/logo.png",
                          fit: BoxFit.cover)),
                  const Text(
                    "AGU",
                    style: TextStyle(fontSize: 20, letterSpacing: 3),
                  ),
                ],
              ),
              SearchBarWidget(
                isReadOnly: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationsScreen()));
                    },
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    UserInfoMethods.user.userName,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CircleAvatar(
                    //  backgroundImage: MemoryImage(bytes),
                    backgroundImage: NetworkImage(Utils.circleAvatarUrl),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
