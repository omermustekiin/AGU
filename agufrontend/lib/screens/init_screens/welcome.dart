import 'package:agufrontend/screens/init_screens/register.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[800],
          actions: [
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                    height: 28,
                    child: Image.asset("assets/images/logo.png",
                        fit: BoxFit.cover)),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  "ANONİM GÜNLÜK UYGULAMASI",
                  style: TextStyle(fontSize: 16, letterSpacing: 0.5),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: const Text(
                    "Giriş yap",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                  },
                  child: const Text(
                    "Kayıt ol",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            )
          ],
        ),
        body: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 370,
                  child: Image.asset(
                    "assets/images/welcomebackground.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 55.0, horizontal: 18),
                  child: Text(
                    "Düşüncelerinizi, duygularınızı\nve deneyimlerinizi günlük\ntopluluğunuzla paylaşın!",
                    style: TextStyle(
                        fontFamily: '',
                        color: Colors.deepPurple,
                        fontSize: 50,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
            const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.menu_book_outlined,
                            color: Colors.deepPurple,
                            size: 40,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "OKU",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Topluluğunuzun eşsiz \n deneyimlerini okuyun",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.share_outlined,
                            color: Colors.deepPurple,
                            size: 40,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "PAYLAŞ",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Topluluğunuzla kendi\ndeneyimlerinizi paylaşın",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.timer_sharp,
                            color: Colors.deepPurple,
                            size: 40,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "ZAMANLA",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Deneyimlerinizi kendi\nbelirlediğiniz vakitte paylaşın",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  width: 50,
                  thickness: 5,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                  child: Text(
                    "Kişisel çevrimici\ngünlüğünüze yazın,\npaylaşın ve\ntopluluğunuzu büyütün.",
                    style: TextStyle(fontSize: 24),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
