import 'package:cowlar_task/core/constants/app_colors.dart';
import 'package:cowlar_task/core/routes/router.dart';
import 'package:cowlar_task/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class Utils {
  static showSnackbar({
    required String message,
    bool isError = false,
  }) {
    return ScaffoldMessenger.of(rootNavigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        content: TextWidgets.generalText(message, color: AppColors.whiteColor),
        backgroundColor: isError ? Colors.redAccent : AppColors.primaryColor,
      ),
    );
  }
}
