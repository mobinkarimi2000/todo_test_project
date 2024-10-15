import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_test_project/core/utils/utils.dart';

import 'package:todo_test_project/features/todo/domain/models/todo_model.dart';
import 'package:todo_test_project/features/todo/presentation/controllers/todo_controller.dart';

class TodoCard extends StatelessWidget {
  TodoCard({
    super.key,
    required this.todoModel,
  });
  final TodoModel todoModel;
  final TodoController todoController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            createCheckBox(),
            const SizedBox(
              width: 10,
            ),
            createText(),
            createDeleteButton(context)
          ],
        ),
      ),
    );
  }

  Container createCheckBox() {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 1),
          borderRadius: BorderRadius.circular(5)),
      child: Checkbox(
        visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
        value: todoModel.completed,
        onChanged: (value) {
          todoController.updateTodo(TodoModel(
            id: todoModel.id,
            completed: !(todoModel.completed ?? false),
            todo: todoModel.todo,
            userId: todoModel.userId,
          ));
        },
        checkColor: Colors.blue,
        fillColor: const WidgetStatePropertyAll(Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: BorderSide.none,
      ),
    );
  }

  Expanded createText() => Expanded(child: Text(todoModel.todo ?? ""));

  IconButton createDeleteButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Utils.showConfirmDialog(
            title: 'delete todo',
            message: 'do you want to delete this item?  ',
            onConfirm: () {
              todoController.deleteTodo(todoModel.id!);
            },
            onRefresh: () {},
            context: context);
      },
      icon: const Icon(Icons.delete_outline_rounded),
      color: Colors.red,
    );
  }
}
