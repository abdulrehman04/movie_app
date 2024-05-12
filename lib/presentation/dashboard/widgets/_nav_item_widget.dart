part of '../dashboard_view.dart';

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
            TextWidgets.generalText(
              item.title,
              color: AppColors.whiteColor,
            ),
        ],
      ),
    );
  }
}
