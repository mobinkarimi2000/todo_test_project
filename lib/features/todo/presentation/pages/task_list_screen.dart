import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_test_project/core/locator/locator.dart';
import 'package:todo_test_project/features/todo/presentation/controllers/todo_controller.dart';
import 'package:todo_test_project/features/todo/presentation/widgets/add_todo_widget.dart';
import 'package:todo_test_project/features/todo/presentation/widgets/todo_list_widget.dart';
import 'package:go_router/go_router.dart';

class TaskListScreen extends StatelessWidget {
  TaskListScreen({super.key});
  final TodoController todoController = Get.put(locator<TodoController>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('todos', style: TextStyle(color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ScaffoldMessenger(
              child: Builder(builder: (context) {
                final theme = Theme.of(context);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (context.canPop()) {
                          context.pop();
                        }
                      },
                      child: Dialog(
                        backgroundColor: theme.scaffoldBackgroundColor,
                        surfaceTintColor: theme.scaffoldBackgroundColor,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        insetPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                              onTap: () {}, child: AddTodoWidget()),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          TodoListWidget(),
        ],
      ),
    );
  }
}
