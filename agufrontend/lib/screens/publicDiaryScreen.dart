import 'package:agufrontend/resources/post_methods.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';
import '../constants/utils.dart';
import '../widgets/drawer.dart';
import '../widgets/navbar.dart';

class PublicDiaryScreen extends StatefulWidget {
  const PublicDiaryScreen({Key? key}) : super(key: key);
  static TextEditingController publicPostTitleController =
      TextEditingController();
  static TextEditingController publicPostTextController =
      TextEditingController();

  @override
  State<PublicDiaryScreen> createState() => _PublicDiaryScreenState();
}

class _PublicDiaryScreenState extends State<PublicDiaryScreen> {
  DateTime selectedValue = DateTime.now();
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedValue);
    DateTime fifteenDaysAgo = now.subtract(const Duration(days: 12));

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: const MyNavigationDrawer(),
      appBar: const NavBar(),
      body: Center(
        child: Container(
          width: w - 200,
          height: h - 80,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.purple, width: 1),
              borderRadius: BorderRadius.circular(15)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///Başlık
                TextField(
                    textAlign: TextAlign.center,
                    maxLength: 50,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                    controller: PublicDiaryScreen.publicPostTitleController,
                    decoration: InputDecoration(
                        focusColor: Colors.purple,
                        hoverColor: Colors.purple,
                        fillColor: Colors.purple,
                        hintText:
                            "Bugün yaşadıklarınızı tanımlayan en iyi başlık ne olurdu?",
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.4)))),

                ///Metin
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextField(
                    textAlign: TextAlign.justify,
                    maxLines: null,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    controller: PublicDiaryScreen.publicPostTextController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      hintText: "Bugün neler yaşadınız?",
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.4)),
                    ),
                  ),
                ),

                SizedBox(
                  height: h - 340,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DatePicker(
                      fifteenDaysAgo,
                      initialSelectedDate: DateTime.now(),
                      selectionColor: Colors.black,
                      selectedTextColor: Colors.white,
                      onDateChange: (date) {
                        // New date selected
                        setState(() {
                          selectedValue = date;
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(
                  width: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        backgroundColor: Colors.purple,
                      ),
                      onPressed: () async {
                        String output = await PostMethods().createPublicPost(
                            PublicDiaryScreen.publicPostTextController.text,
                            PublicDiaryScreen.publicPostTitleController.text,
                            formattedDate);
                        if (output == "Success") {
                          await PostMethods().getAllPublicPosts();
                          setState(() {});
                          Utils().showAlertDialog(context,
                              "Herkese Açık Günlük Başarıyla Oluşturuldu!");
                        } else {
                          Utils().showAlertDialog(context, output);
                        }
                      },
                      child: const Text("Paylaş"),
                    ),
                    Icon(
                      Icons.lock_open,
                      color: mainColor,
                    ),
                  ],
                ),

                const SizedBox(width: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
