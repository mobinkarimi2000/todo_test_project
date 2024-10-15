import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todo_test_project/core/error_handling/custom_exception.dart';
import 'package:todo_test_project/core/utils/constants.dart';
import 'package:todo_test_project/core/utils/utils.dart';
import 'dart:io';

import 'package:todo_test_project/features/todo/data/datasources/network/abstraction/todo_data_source.dart';
import 'package:todo_test_project/features/todo/data/datasources/network/dto/todo_dto.dart';
import 'package:todo_test_project/features/todo/data/datasources/network/dto/todo_list_dto.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_list_params.dart';

class TodoDataSourceImpl extends TodoDataSource {
  final Dio _dio;

  TodoDataSourceImpl(this._dio);
  @override
  Future<Unit> addTodo(TodoDto dto) async {
    try {
      final response = await _dio.post(
        '${URLPath.BASE_URL}${URLPath.ADD_TODO}',
        data: {
          'todo': dto.todo,
          'completed': dto.completed,
          'userId': dto.userId,
        },
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 201) {
        return unit;
      } else {
        throw RestApiException(response.statusCode, response.statusMessage);
      }
    } on DioException catch (e) {
      throw Utils.handleDioException(e);
    }
  }

  @override
  Future<Unit> deleteTodo(int id) async {
    try {
      final response = await _dio.delete(
        '${URLPath.BASE_URL}${URLPath.TODO}/$id',
      );

      if (response.statusCode == 200) {
        return unit;
      } else {
        throw RestApiException(response.statusCode, response.statusMessage);
      }
    } on DioException catch (e) {
      throw Utils.handleDioException(e);
    }
  }

  @override
  Future<TodoListDto> getTodoList(TodoListParams params) async {
    try {
      final response = await _dio.get(
        '${URLPath.BASE_URL}${URLPath.TODO_LIST}/${5}',
        queryParameters: {
          'limit': params.pageSize,
          'skip': params.pageNumber,
        },
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        return TodoListDto.fromJson(response.data);
      } else {
        throw RestApiException(response.statusCode, response.statusMessage);
      }
    } on DioException catch (e) {
      throw Utils.handleDioException(e);
    }
  }

  @override
  Future<Unit> updateTodo(TodoDto dto) async {
    try {
      final response = await _dio.put(
        '${URLPath.BASE_URL}${URLPath.TODO}${dto.id}',
        data: {
          'completed': dto.completed,
        },
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        return unit;
      } else {
        throw RestApiException(response.statusCode, response.statusMessage);
      }
    } on DioException catch (e) {
      throw Utils.handleDioException(e);
    }
  }
}
