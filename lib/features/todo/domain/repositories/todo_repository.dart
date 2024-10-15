import 'package:dartz/dartz.dart';
import 'package:todo_test_project/core/error_handling/failure.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_list_model.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_list_params.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_model.dart';

abstract class TodoRepository {
  Future<Either<Failure, TodoListModel>> getTodoList(TodoListParams params);
  Future<Either<Failure, Unit>> addTodo(TodoModel todoModel);
  Future<Either<Failure, Unit>> updateTodo(TodoModel todoModel);
  Future<Either<Failure, Unit>> deleteTodo(int id);
}
