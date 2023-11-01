import 'package:agufrontend/resources/user_information_methods.dart';
import 'package:agufrontend/screens/init_screens/register.dart';
import 'package:flutter/material.dart';

import '../../constants/utils.dart';
import '../../resources/auth_methods.dart';
import '../../widgets/button.dart';
import '../../widgets/text_field.dart';
import '../home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///Login Form
                Container(
                  height: 500,
                  width: 500,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple, width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ///Giriş Yap text
                      const Text(
                        "Giriş Yap",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                            color: Colors.deepPurple),
                      ),

                      ///Username input
                      MyTextFieldWidget(
                        hintText: "Kullanıcı adı giriniz...",
                        title: "Kullanıcı Adı",
                        controller: usernameController,
                        obscureText: false,
                      ),

                      ///Password input
                      MyTextFieldWidget(
                        hintText: "Şifre giriniz...",
                        title: "Şifre",
                        controller: passwordController,
                        obscureText: true,
                      ),

                      ///Giriş Yap button
                      Align(
                        alignment: Alignment.center,
                        child: MyCustomMainButton(
                          isLoading: false,
                          color: Colors.deepPurple,
                          onPressed: () async {
                            String output = await AuthMethods().login(
                                usernameController.text,
                                passwordController.text);
                            if (output == "Success") {
                              AuthMethods.userId = await AuthMethods()
                                  .getUserId(usernameController.text,
                                      passwordController.text);
                              setState(() {});
                              await UserInfoMethods().getUserById();
                              if (!mounted) return;
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                            } else {
                              if (!mounted) return;
                              Utils().showAlertDialog(context, output);
                            }
                          },
                          child: const Text(
                            "Giriş yap",
                            style: TextStyle(
                                letterSpacing: 0.6, color: Colors.white),
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                          child: const Text(
                            "Henüz üye değil misin? Üye Ol.",
                            style: TextStyle(
                                letterSpacing: 0.6, color: Colors.deepPurple),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
