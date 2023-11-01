import 'package:flutter/material.dart';

import '../widgets/drawer.dart';
import '../widgets/navbar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: MyNavigationDrawer(),
      appBar: NavBar(),
      body: Center(
        child: Text("mesaj sayfası"),
      ),
    );
  }
}
