import 'package:dartz/dartz.dart';
import 'package:todo_test_project/features/todo/data/datasources/network/dto/todo_dto.dart';
import 'package:todo_test_project/features/todo/data/datasources/network/dto/todo_list_dto.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_list_params.dart';

abstract class TodoDataSource {
  Future<TodoListDto> getTodoList(TodoListParams params);
  Future<TodoDto> addTodo(TodoDto dto);
  Future<Unit> updateTodo(TodoDto dto);
  Future<Unit> deleteTodo(int id);
}
