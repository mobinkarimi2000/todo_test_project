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
      floatingActionButton: createAddButton(context),
      body: Column(
        children: [
          createFilters(),
          TodoListWidget(),
        ],
      ),
    );
  }

  FloatingActionButton createAddButton(BuildContext context) {
    return FloatingActionButton(
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
    );
  }

  Padding createFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
      child: Obx(
        () => Row(
          children: [
            InkWell(
              onTap: () {
                todoController.showAll();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: todoController.allFilters.value ? Colors.blue : null,
                    border: Border.all(
                      width: 2,
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "all",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () {
                todoController.showCompleted();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: todoController.completedFilters.value
                        ? Colors.blue
                        : null,
                    border: Border.all(
                      width: 2,
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "completed",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () {
                todoController.showUncompleted();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: todoController.uncompletedFilters.value
                        ? Colors.blue
                        : null,
                    border: Border.all(
                      width: 2,
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "uncompleted",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
