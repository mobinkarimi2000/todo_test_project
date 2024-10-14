import 'package:flutter/material.dart';
import 'package:todo_test_project/core/extension/shared_preferences_manager.dart';
import 'package:todo_test_project/core/locator/locator.dart';

SharedPreferencesManager sharedPreferencesManager = locator();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
