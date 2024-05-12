part of '../dashboard_vm.dart';

List<NavItemModel> _navData = [
  NavItemModel(Icons.home, 'Home'),
  NavItemModel(Icons.search, 'Search'),
  NavItemModel(Icons.favorite, 'Likes'),
  NavItemModel(Icons.person, 'Profile'),
];

class NavItemModel {
  String title;
  IconData icon;

  NavItemModel(this.icon, this.title);
}
