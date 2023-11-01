import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../constants/utils.dart';
import '../../resources/user_information_methods.dart';
import '../../widgets/button.dart';
import '../../widgets/text_field.dart';
import '../home.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreen();
}

class _CreateProfileScreen extends State<CreateProfileScreen> {
  Uint8List? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    surnameController.dispose();
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
                      ///Profil Oluştur
                      const Text(
                        "Profil Oluştur",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                            color: Colors.deepPurple),
                      ),

                      ///Image
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          image == null
                              ? GestureDetector(
                                  onTap: () async {
                                    Uint8List? temp = await Utils().pickImage();
                                    if (temp != null) {
                                      setState(() {
                                        image = temp;
                                      });
                                    }
                                  },
                                  child: SizedBox(
                                    height: screenSize.height / 8.5,
                                    child: Image.network(
                                        "https://st2.depositphotos.com/3904951/8925/v/600/depositphotos_89250312-stock-illustration-photo-picture-web-icon-in.jpg"),
                                  ),
                                )
                              : Image.memory(
                                  height: screenSize.height / 8.25,
                                  fit: BoxFit.cover,
                                  image!,
                                ),
                          IconButton(
                            padding: const EdgeInsets.only(left: 40, top: 18),
                            onPressed: () async {
                              Uint8List? temp = await Utils().pickImage();
                              if (temp != null) {
                                setState(() {
                                  image = temp;
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 26,
                            ),
                          ),
                        ],
                      ),

                      ///Name input
                      MyTextFieldWidget(
                        hintText: "Adınızı yazınız...",
                        title: "Ad",
                        controller: nameController,
                        obscureText: false,
                      ),

                      ///Birthday

                      ///Buttons
                      Align(
                        alignment: Alignment.center,
                        child: MyCustomMainButton(
                          isLoading: false,
                          color: Colors.deepPurple,
                          onPressed: () async {
                            setState(() {
                              // UserInfoMethods.user.avatar = image;
                              UserInfoMethods.user.nameSurname =
                                  nameController.text.trim();
                            });
                            await UserInfoMethods().getUserById();
                            if (!mounted) return;
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          },
                          child: const Text(
                            "Başla",
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
                                          const HomeScreen()));
                            },
                            child: const Text(
                              "Anonim devam etmek istiyorum",
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
