import 'package:flutter/material.dart';

import '../widgets/drawer.dart';
import '../widgets/navbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: MyNavigationDrawer(),
      appBar: NavBar(),
      body: Center(
        child: Text("ayarlar sayfası"),
      ),
    );
  }
}
