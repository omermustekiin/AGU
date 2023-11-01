import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  static int publicPostSize = 0;
  static int privatePostSize = 0;
  static String circleAvatarUrl =
      "https://st2.depositphotos.com/1032921/5237/v/380/depositphotos_52374307-stock-illustration-blue-profile-icon.jpg";

  Size getScreenSize() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  }

/*  void navigateToPage(BuildContext context, String route) {
    final newUrl = Uri(path: route).toString();
    html.window.history.pushState(null, '', newUrl);
    Navigator.pushReplacementNamed(context, route);
  }*/

  showAlertDialog(BuildContext context, String output) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Tamam"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Bilgilendirme",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
      ),
      content: Text(
        output,
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<Uint8List?> pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    return file!.readAsBytes();
  }

  String uint8ListToUrl(Uint8List uint8List) {
    String base64String = base64.encode(uint8List);

    String url = 'data:image/jpeg;base64,$base64String';

    return url;
  }
}
