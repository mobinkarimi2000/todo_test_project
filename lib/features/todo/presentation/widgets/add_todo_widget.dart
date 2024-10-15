import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_test_project/core/widgets/custom_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_model.dart';
import 'package:todo_test_project/features/todo/presentation/controllers/todo_controller.dart';
import 'package:todo_test_project/main.dart';

class AddTodoWidget extends StatelessWidget {
  AddTodoWidget({super.key});
  final TextEditingController textEditingController = TextEditingController();
  final TodoController todoController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 200,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.close_rounded)),
            ],
          ),
          CustomTextFormField(
            hintText: 'example: fix garage door ',
            mainText: '',
            controller: textEditingController,
            onChange: (value) {},
            cursorColor: Colors.blue,
            validator: (value) {},
            obscureText: false,
          ),
          TextButton(
              onPressed: () {
                todoController.addTodo(TodoModel(
                  userId: sharedPreferencesManager.getUserID(),
                  completed: false,
                  todo: textEditingController.text,
                ));
                context.pop();
              },
              child: const Text('add', style: TextStyle(color: Colors.blue)))
        ],
      ),
    );
  }
}
