import 'package:flutter/material.dart';

import '../constants/utils.dart';

class SearchBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool isReadOnly;

  SearchBarWidget({
    Key? key,
    required this.isReadOnly,
  })  : preferredSize = const Size.fromHeight(50),
        super(key: key);

  @override
  final Size preferredSize;

  OutlineInputBorder myBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey, width: 1));

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      height: 50,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: screenSize.width * 0.5,
            height: 45,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(
                      0,
                      5,
                    ),
                  ),
                ],
              ),
              child: TextField(
                onSubmitted: (String query) {
                  /*       Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsScreen(query: query),
                    ),
                  );*/
                },
                readOnly: isReadOnly,
                onTap: () {
                  /*  if (isReadOnly) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen()));
                  }*/
                },
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: myBorder,
                    focusedBorder: myBorder,
                    hintText: "Bir arama yapınız"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
