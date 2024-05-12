import 'package:cowlar_task/core/constants/app_colors.dart';
import 'package:cowlar_task/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLongButton extends StatelessWidget {
  const CustomLongButton({
    super.key,
    this.onTap,
    required this.title,
    this.height = 52,
    this.width = 340,
    this.buttonColor,
    this.borderColor,
    this.textColor = Colors.white,
  });

  final void Function()? onTap;
  final String title;
  final double height, width;
  final Color? buttonColor, textColor, borderColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: onTap == null
              ? (buttonColor ?? AppColors.primaryColor).withOpacity(0.8)
              : buttonColor,
          border: Border.all(
            color: onTap == null
                ? (borderColor ?? AppColors.primaryColor).withOpacity(0.8)
                : (borderColor ?? AppColors.primaryColor),
          ),
        ),
        child: Center(
          child: TextWidgets.generalText(
            title,
            fontSize: 18,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
