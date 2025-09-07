import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle cardPriceStyle = getTextStyle(40, FontWeight.normal);
  static TextStyle onBoardingTitle = getTextStyle(36, FontWeight.w500);

  ///h1
  static TextStyle h1 = getTextStyle(32, FontWeight.normal);

  static TextStyle h1SemiBold = getTextStyle(32, FontWeight.w600);

  static TextStyle h1Bold = getTextStyle(32, FontWeight.w700);

  static TextStyle h1ExtraBold = getTextStyle(32, FontWeight.w900);

  ///h2
  static TextStyle h2 = getTextStyle(30, FontWeight.normal);
  static TextStyle h2Bold = getTextStyle(30, FontWeight.bold);

  static TextStyle h2ExtraBold = getTextStyle(30, FontWeight.w900);

  ///h3
  static TextStyle h3 = getTextStyle(24, FontWeight.normal);
  static TextStyle h3Plus = getTextStyle(24, FontWeight.w500);

  static TextStyle h3SemiBold = getTextStyle(24, FontWeight.w600);

  static TextStyle h3Bold = getTextStyle(24, FontWeight.w700);

  static TextStyle h3ExtraBold = getTextStyle(24, FontWeight.w900);

  ///h4
  static TextStyle h4 = getTextStyle(20, FontWeight.normal);

  static TextStyle h4SemiBold = getTextStyle(20, FontWeight.w600);

  static TextStyle h4ExtraBold = getTextStyle(20, FontWeight.w800);

  ///p1
  static TextStyle p1 = getTextStyle(18, FontWeight.normal);

  static TextStyle p1Medium = getTextStyle(18, FontWeight.w500);

  static TextStyle p1SemiBold = getTextStyle(18, FontWeight.w600);

  static TextStyle p1Bold = getTextStyle(18, FontWeight.w700);

  static TextStyle p1ExtraBold = getTextStyle(18, FontWeight.w800);

  ///p2
  static TextStyle p2 = getTextStyle(16, FontWeight.normal);
  static TextStyle p2Light = getTextStyle(16, FontWeight.w400);

  static TextStyle p2Medium = getTextStyle(16, FontWeight.w500);
  static TextStyle p2MediumPlus = getTextStyle(16, FontWeight.w600);

  static TextStyle p2Bold = getTextStyle(16, FontWeight.w700);

  static TextStyle p2ExtraBold = getTextStyle(16, FontWeight.w900);

  ///p3
  static TextStyle p3 = getTextStyle(14, FontWeight.normal);
  static TextStyle p3Size15 = getTextStyle(15, FontWeight.normal);

  static TextStyle p3size15w500 = getTextStyle(15, FontWeight.w500);
  static TextStyle p3Plus = getTextStyle(14, FontWeight.w500);

  static TextStyle p3SemiBold = getTextStyle(14, FontWeight.w600);

  static TextStyle p3Bold = getTextStyle(14, FontWeight.w700);

  static TextStyle p3ExtraBold = getTextStyle(14, FontWeight.w800);

  static TextStyle p3Medium = p3.copyWith(fontWeight: FontWeight.w500);

  ///p4
  static TextStyle p4 = getTextStyle(12, FontWeight.normal);

  static TextStyle p4Medium = getTextStyle(12, FontWeight.w500);

  static TextStyle p4SemiBold = getTextStyle(12, FontWeight.w600);

  static TextStyle p4Bold = getTextStyle(12, FontWeight.w700);

  static TextStyle p4ExtraBold = getTextStyle(12, FontWeight.w800);

  ///caption
  static TextStyle caption = getTextStyle(12, FontWeight.normal);
  static TextStyle captionExtra = getTextStyle(13, FontWeight.normal);
  static TextStyle captionlight = getTextStyle(13, FontWeight.w300);

  static TextStyle captionExtraMedium = getTextStyle(13, FontWeight.w500);
  static TextStyle captionSemiBold = getTextStyle(12, FontWeight.w600);

  ///subtitle
  static TextStyle subtitle = getTextStyle(10, FontWeight.normal);
  static TextStyle subtitleLight = getTextStyle(11, FontWeight.w300);

  static TextStyle subtitleMedium = getTextStyle(10, FontWeight.w500);

  static TextStyle getTextStyle(double fontSize, FontWeight fontWeight, {Color? color}) => TextStyle(
        fontFamily: 'Euclid Circular A',
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: 19.5 / 14,
        letterSpacing: -0.36,
        color: color ?? Colors.white,
      );
}
