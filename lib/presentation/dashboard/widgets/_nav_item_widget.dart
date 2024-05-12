import 'package:cowlar_task/core/constants/app_colors.dart';
import 'package:cowlar_task/presentation/dashboard/dashboard_vm.dart';
import 'package:flutter/material.dart';

class NavItemWidget extends StatelessWidget {
  const NavItemWidget({
    super.key,
    required this.item,
    this.isSelected = false,
    this.onTap,
  });

  final NavItemModel item;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            item.icon,
            color: isSelected ? AppColors.whiteColor : Colors.grey,
          ),
          if (isSelected)
            Text(
              item.title,
              style: TextStyle(color: AppColors.whiteColor),
            ),
        ],
      ),
    );
  }
}
