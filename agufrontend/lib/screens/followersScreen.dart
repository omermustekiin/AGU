import 'package:agufrontend/widgets/follower_widget.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../widgets/drawer.dart';
import '../widgets/navbar.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyNavigationDrawer(),
      appBar: const NavBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Takipçilerim",
                    style: TextStyle(
                        fontSize: 20,
                        color: mainColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.filter_alt,
                    color: mainColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        FollowerWidget(
                          btnText: "Takipçiyi Çıkar",
                          followeruserName: 'Efe',
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
