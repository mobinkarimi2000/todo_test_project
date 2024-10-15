import 'package:todo_test_project/features/todo/presentation/controllers/status/todo_list_status.dart';

class TodoState {
  final TodoListStatus todoListStatus;

  TodoState({required this.todoListStatus});

  TodoState copyWith({TodoListStatus? newTodoListStatus}) {
    return TodoState(todoListStatus: newTodoListStatus ?? todoListStatus);
  }
}
