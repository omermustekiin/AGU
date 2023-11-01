import 'package:flutter/material.dart';

import '../constants/colors.dart';

class Tag extends StatelessWidget {
  const Tag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: mainColor,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "#Sanat",
        style: TextStyle(color: mainColor),
      ),
    );
  }
}
