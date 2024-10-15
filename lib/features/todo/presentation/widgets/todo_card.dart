import 'package:flutter/material.dart';

import 'package:todo_test_project/features/todo/domain/models/todo_model.dart';

class TodoCard extends StatefulWidget {
  const TodoCard({
    super.key,
    required this.todoModel,
  });
  final TodoModel todoModel;
  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
