import 'package:cowlar_task/presentation/dashboard/dashboard_vm.dart';
import 'package:cowlar_task/presentation/dashboard/widgets/_nav_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DashboardViewModel controller = ref.watch(dashboardViewModelProvider);
    return Scaffold(
      body: controller.getBody(),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.grey[900],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: controller.navItems.map<Widget>((item) {
            return NavItemWidget(
              onTap: () {
                controller.setDestination(
                  controller.navItems.indexOf(item),
                );
              },
              item: item,
              isSelected: controller.isSelected(
                controller.navItems.indexOf(item),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
