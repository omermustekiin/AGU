import 'package:agufrontend/resources/auth_methods.dart';
import 'package:agufrontend/screens/chatScreen.dart';
import 'package:agufrontend/screens/followersScreen.dart';
import 'package:agufrontend/screens/followingsScreen.dart';
import 'package:agufrontend/screens/home.dart';
import 'package:agufrontend/screens/init_screens/welcome.dart';
import 'package:agufrontend/screens/privateDiaryScreen.dart';
import 'package:agufrontend/screens/profileScreen.dart';
import 'package:agufrontend/screens/publicDiaryScreen.dart';
import 'package:agufrontend/screens/savedScreen.dart';
import 'package:agufrontend/screens/settingsScreen.dart';
import 'package:flutter/material.dart';

import '../constants/utils.dart';
import '../resources/user_information_methods.dart';
import '../screens/notifications.dart';

class MyNavigationDrawer extends StatefulWidget {
  const MyNavigationDrawer({Key? key}) : super(key: key);

  @override
  State<MyNavigationDrawer> createState() => _MyNavigationDrawerState();
}

class _MyNavigationDrawerState extends State<MyNavigationDrawer> {
  //Uint8List bytes = UserInfoMethods.user.avatar.buffer.asUint8List();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.4, 0.9],
          colors: [
            Colors.deepPurple,
            Colors.white,
          ],
        ),
      ),
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width / 30,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 130,
              width: 130,
              child: CircleAvatar(
                //  backgroundImage: MemoryImage(bytes),
                backgroundImage: NetworkImage(Utils.circleAvatarUrl),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              UserInfoMethods.user.userName,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 45, bottom: 45),
      child: Wrap(
        runSpacing: 0,
        children: [
          ListTile(
            leading: const Icon(
              Icons.my_library_books_outlined,
              color: Colors.white,
            ),
            title: const Text(
              "Akış",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.message,
              color: Colors.white,
            ),
            title: const Text(
              "Mesajlar",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            title: const Text(
              "Bildirimler",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: const Text(
              "Profil",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.book_outlined,
              color: Colors.white,
            ),
            title: const Text(
              "Herkese Açık Günlük",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PublicDiaryScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.lock_person,
              color: Colors.white,
            ),
            title: const Text(
              "Gizli Günlük",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivateDiaryScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.people,
              color: Colors.white,
            ),
            title: const Text(
              "Takip Ettiklerim",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FollowingsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.people,
              color: Colors.white,
            ),
            title: const Text(
              "Takipçilerim",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FollowersScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings_outlined,
              color: Colors.white,
            ),
            title: const Text(
              "Ayarlar",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            title: const Text(
              "Kaydedilenler",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SavedScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.output,
              color: Colors.white,
            ),
            title: const Text(
              "Çıkış Yap",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () async {
              String output = await AuthMethods().logout();
              if (output == "Success") {
                if (!mounted) return;
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()));
              } else {
                if (!mounted) return;
                Utils().showAlertDialog(context, output);
              }
            },
          ),
        ],
      ),
    );
  }
}
