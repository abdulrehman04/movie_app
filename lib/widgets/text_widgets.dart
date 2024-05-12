import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidgets {
  static Widget generalText(
    String text, {
    double fontSize = 14,
    fontWeight = FontWeight.w400,
    color = Colors.black,
    double height = 1.5,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text(
      text,
      style: GoogleFonts.interTight(
        color: color,
        height: height,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
      ),
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  static headingWidget(String title) {
    return generalText(
      title,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );
  }
}
