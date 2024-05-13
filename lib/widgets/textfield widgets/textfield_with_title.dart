import 'package:cowlar_task/core/constants/app_colors.dart';
import 'package:cowlar_task/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextfieldWithTitle extends StatelessWidget {
  const TextfieldWithTitle(
      {super.key,
      this.title,
      this.controller,
      this.iconData,
      this.keyboardType = TextInputType.text,
      this.iconPadding = const EdgeInsets.all(15),
      this.isObscure = false,
      this.validator,
      this.lines = 1,
      this.maxLength,
      this.hint});

  final String? title;
  final String? hint;
  final String? iconData;
  final TextEditingController? controller;
  final EdgeInsets iconPadding;
  final bool isObscure;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int lines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: lines,
      maxLength: maxLength,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      obscureText: isObscure,
      style: GoogleFonts.interTight(
        fontSize: 14,
      ),
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        counterStyle: TextStyle(color: AppColors.primaryColor),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 15.w),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(10),
        ),
        label: title == null
            ? null
            : TextWidgets.generalText(
                title!,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
      ),
    );
  }
}
