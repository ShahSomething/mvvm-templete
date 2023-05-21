import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//TODO put all the custom text styles here

TextStyle myStyle(
  double size,
  bool isBold, {
  Color color = Colors.black,
  FontWeight? overrideBold = FontWeight.bold,
}) {
  return GoogleFonts.lato(
      fontSize: size,
      fontWeight: (isBold) ? overrideBold : FontWeight.normal,
      color: color);
}
