import 'package:cowlar_task/core/routes/route_names.dart';
import 'package:cowlar_task/presentation/dashboard/dashboard_view.dart';
import 'package:cowlar_task/presentation/movie%20list/movie_list_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class CustomRouter {
  static final config = GoRouter(
    initialLocation: RouteNames.instance.dashboard,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: RouteNames.instance.dashboard,
        name: RouteNames.instance.dashboard,
        builder: (context, state) => const DashboardView(),
      ),
      GoRoute(
        path: RouteNames.instance.movieList,
        name: RouteNames.instance.movieList,
        builder: (context, state) => const MovieList(),
      ),
      // GoRoute(
      //   path: RouteNames.instance.signup,
      //   name: RouteNames.instance.signup,
      //   builder: (context, state) => SignupView(),
      // ),
    ],
  );
}
