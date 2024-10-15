import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_test_project/core/locator/locator.dart';
import 'package:todo_test_project/features/todo/presentation/controllers/todo_controller.dart';
import 'package:todo_test_project/features/todo/presentation/widgets/todo_list_widget.dart';

class TaskListScreen extends StatelessWidget {
  TaskListScreen({super.key});
  final TodoController todoController = Get.put(locator<TodoController>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.add_rounded,
        ),
        color: Colors.white,
      ),
      body: Column(
        children: [
          TodoListWidget(),
        ],
      ),
    );
  }
}
