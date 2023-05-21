import 'package:flutter/material.dart';

//TODO update colors according to your figma design
class AppColors {
  static const Color primaryColor = Color(0xFF35BBBB);
  static const Color secondaryColor = Color(0xFFF6871F);
  static const Color blackColor = Color(0xFF2A3333);
  static const Color greyColor = Color(0xFF6F7B7B);
  static const Color lightGreyColor = Color(0xFFEEEEEE);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color backgoundColor = Color(0xFFFBFBFB);
  static const Color errorColor = Color(0xFFF73838);
  static const LinearGradient gradient = LinearGradient(
    colors: [
      Color(0xFF35BBBB),
      Color(0xFF35BBA2),
      Color.fromARGB(0, 53, 187, 187),
    ],
    transform: GradientRotation(135),
  );
}
