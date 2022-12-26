
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTextStyle {
  static primaryDarkRegular(
          {Color? color = ColorConstants.primaryDarkTextColor,
          required double size}) =>
      primary(color!, size, FontWeight.w400);

  static primaryDarkMedium(
          {Color? color = ColorConstants.primaryDarkTextColor,
          required double size}) =>
      primary(color!, size, FontWeight.w500);

  static primaryDarkBold(
          {Color? color = ColorConstants.primaryDarkTextColor,
          required double size}) =>
      primary(color!, size, FontWeight.w700);

   static primaryLightRegular(
          {Color? color = ColorConstants.primaryLightTextColor,
          required double size}) =>
      primary(color!, size, FontWeight.w400);

  static primaryLightMedium(
          {Color? color = ColorConstants.primaryLightTextColor,
          required double size}) =>
      primary(color!, size, FontWeight.w500);

  static primaryLightBold(
          {Color? color = ColorConstants.primaryLightTextColor,
          required double size}) =>
      primary(color!, size, FontWeight.w700);

  static secondaryDarkBold(
          {Color? color = ColorConstants.secondaryDarkTextColor,
          required double size}) =>
      primary(color!, size, FontWeight.w700);

  static secondaryLightBold(
          {Color? color = ColorConstants.secondaryLightTextColor,
          required double size}) =>
      primary(color!, size, FontWeight.w700);
static secondaryLightRegular(
          {Color? color = ColorConstants.secondaryLightTextColor,
          required double size}) =>
      primary(color!, size, FontWeight.normal);
  static TextStyle primary(Color color, double size, FontWeight fontWeight) {
    return _textStyle("fontFamily", color, size, fontWeight);
  }
}

TextStyle _textStyle(
    String fontFamily, Color color, double size, FontWeight fontWeight) {
      return GoogleFonts.inter(
        decoration: TextDecoration.none,     
      color: color,
      fontSize: size,
      fontWeight: fontWeight
      );
 /*  return TextStyle(
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      color: color,
      fontSize: size,
      fontWeight: fontWeight); */
}
