import 'package:agufrontend/resources/auth_methods.dart';
import 'package:flutter/material.dart';

import '../../constants/utils.dart';
import '../../resources/user_information_methods.dart';
import '../../widgets/button.dart';
import '../../widgets/text_field.dart';
import 'create_profile.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
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
                      ///Üye Ol text
                      const Text(
                        "Üye Ol",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                            color: Colors.deepPurple),
                      ),

                      ///Username input
                      MyTextFieldWidget(
                        hintText: "Kullanıcı adı giriniz...",
                        title: "Kullanıcı Adı",
                        controller: userNameController,
                        obscureText: false,
                      ),

                      ///Email input
                      MyTextFieldWidget(
                        hintText: "Email giriniz...",
                        title: "Email",
                        controller: emailController,
                        obscureText: false,
                      ),

                      ///Password input
                      MyTextFieldWidget(
                        hintText: "Şifre giriniz...",
                        title: "Şifre",
                        controller: passwordController,
                        obscureText: true,
                      ),

                      ///Üye Ol button
                      Align(
                        alignment: Alignment.center,
                        child: MyCustomMainButton(
                            isLoading: false,
                            color: Colors.deepPurple,
                            onPressed: () async {
                              String output = await AuthMethods().register(
                                  userNameController.text,
                                  emailController.text,
                                  passwordController.text);
                              if (output == "Success") {
                                AuthMethods.userId = await AuthMethods()
                                    .getUserId(userNameController.text,
                                        passwordController.text);
                                setState(() {});
                                await UserInfoMethods().getUserById();
                                if (!mounted) return;
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CreateProfileScreen()));
                              } else {
                                if (!mounted) return;

                                Utils().showAlertDialog(context, output);
                              }
                            },
                            child: const Text(
                              "Üye Ol",
                              style: TextStyle(
                                  letterSpacing: 0.6, color: Colors.white),
                            )),
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: const Text(
                              "Zaten bir hesabım var. Giriş Yap.",
                              style: TextStyle(
                                  letterSpacing: 0.6, color: Colors.deepPurple),
                            )),
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