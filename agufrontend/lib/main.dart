import 'package:agufrontend/resources/auth_methods.dart';
import 'package:agufrontend/screens/home.dart';
import 'package:agufrontend/screens/init_screens/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AuthMethods.userId != ""
            ? const HomeScreen()
            : const WelcomeScreen(),
      ),
      initialRoute: '/',
      /*    routes: {
        '/home': (context) => HomeScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/createProfile': (context) => CreateProfileScreen(),
        '/chat': (context) => ChatScreen(),
        '/followers': (context) => FollowersScreen(),
        '/followings': (context) => FollowingsScreen(),
        '/notifications': (context) => NotificationsScreen(),
        '/privateDiary': (context) => PrivateDiaryScreen(),
        '/publicDiary': (context) => PublicDiaryScreen(),
        '/profile': (context) => ProfileScreen(),
        '/saved': (context) => SavedScreen(),
        '/settings': (context) => SettingsScreen(),
      },*/
    );
  }
}
