import 'package:todo_test_project/core/error_handling/failure.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_model.dart';

abstract class TodoListStatus {}

class TodoListInitial extends TodoListStatus {}

class TodoListLoading extends TodoListStatus {}

class TodoListLoadingMore extends TodoListStatus {}

class TodoListEmpty extends TodoListStatus {}

class TodoListCompleted extends TodoListStatus {
  final List<TodoModel> list;

  TodoListCompleted({required this.list});
}

class TodoListError extends TodoListStatus {
  final Failure failure;
  TodoListError({
    required this.failure,
  });
}

class TodoListLoadedMoreError extends TodoListStatus {}
