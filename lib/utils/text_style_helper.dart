
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appTextStyle({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
}) {
  return GoogleFonts.robotoSlab(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}