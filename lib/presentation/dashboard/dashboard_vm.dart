import 'package:cowlar_task/presentation/mqtt/mqtt_view.dart';
import 'package:flutter/material.dart';
import 'package:cowlar_task/presentation/movie%20list/movie_list_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part './data/_nav_bar_data.dart';
part './data/_nav_pages.dart';

final dashboardViewModelProvider = ChangeNotifierProvider((ref) {
  return DashboardViewModel();
});

class DashboardViewModel extends ChangeNotifier {
  int selectedIndex = 0;
  List<NavItemModel> get navItems => _navData;
  List<Widget> get navDestinations => _navPages;

  isSelected(int index) {
    return selectedIndex == index;
  }

  Widget getBody() {
    return navDestinations[selectedIndex];
  }

  setDestination(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
