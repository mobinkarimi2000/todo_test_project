import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_test_project/core/utils/route_names.dart';
import 'package:todo_test_project/features/todo/presentation/pages/task_list_screen.dart';

DateTime? currentBackPressTime;

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

final GoRouter router = GoRouter(
  navigatorKey: NavigationService.navigatorKey,
  initialLocation: RouteNames.taskList,
  routes: [
    GoRoute(
      path: RouteNames.taskList,
      name: RouteNames.splashScreen,
      builder: (context, state) => TaskListScreen(),
    ),
  ],
);
