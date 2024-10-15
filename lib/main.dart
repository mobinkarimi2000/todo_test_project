import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_test_project/core/extension/shared_preferences_manager.dart';
import 'package:todo_test_project/core/locator/locator.dart';
import 'package:todo_test_project/core/router/router.dart';

SharedPreferencesManager sharedPreferencesManager = locator();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupInjection();

  sharedPreferencesManager.setUserID(5);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
      title: 'todos',
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
