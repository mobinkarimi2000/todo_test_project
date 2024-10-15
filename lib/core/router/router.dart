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
  initialLocation: RouteNames.todoList,
  routes: [
    GoRoute(
      path: RouteNames.todoList,
      name: RouteNames.todoList,
      builder: (context, state) => TaskListScreen(),
    ),
  ],
);
