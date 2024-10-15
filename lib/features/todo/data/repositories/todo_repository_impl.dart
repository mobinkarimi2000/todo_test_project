import 'package:dartz/dartz.dart';
import 'package:todo_test_project/core/error_handling/custom_exception.dart';
import 'package:todo_test_project/core/error_handling/failure.dart';
import 'package:todo_test_project/core/utils/utils.dart';
import 'package:todo_test_project/features/todo/data/datasources/network/abstraction/todo_data_source.dart';
import 'package:todo_test_project/features/todo/data/datasources/network/mapper/todo_list_mapper.dart';
import 'package:todo_test_project/features/todo/data/datasources/network/mapper/todo_mapper.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_list_model.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_list_params.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_model.dart';
import 'package:todo_test_project/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final TodoDataSource _todoDataSource;
  final TodoMapper _todoMapper;
  final TodoListMapper _todoListMapper;

  TodoRepositoryImpl(
      this._todoDataSource, this._todoMapper, this._todoListMapper);
  @override
  Future<Either<Failure, TodoModel>> addTodo(TodoModel todoModel) async {
    try {
      final dto =
          await _todoDataSource.addTodo(_todoMapper.mapToEntity(todoModel));
      final model = _todoMapper.mapFromEntity(dto);
      return right(model);
    } on NoInternetConnectionException {
      return left(NoInternetConnectionFailure());
    } on BadRequestException catch (e) {
      return left(
          BadRequestFailure(errorCode: e.errorCode, message: e.errorMessage));
    } on RestApiException catch (e) {
      return left(Utils.handleRestApiException(e));
    } catch (e) {
      return left(Utils.handleUnknownException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTodo(int id) async {
    try {
      final unit = await _todoDataSource.deleteTodo(id);

      return right(unit);
    } on NoInternetConnectionException {
      return left(NoInternetConnectionFailure());
    } on BadRequestException catch (e) {
      return left(
          BadRequestFailure(errorCode: e.errorCode, message: e.errorMessage));
    } on RestApiException catch (e) {
      return left(Utils.handleRestApiException(e));
    } catch (e) {
      return left(Utils.handleUnknownException(e));
    }
  }

  @override
  Future<Either<Failure, TodoListModel>> getTodoList(
      TodoListParams params) async {
    try {
      final dtoList = await _todoDataSource.getTodoList(params);
      final modelList = _todoListMapper.mapFromEntity(dtoList);
      return right(modelList);
    } on NoInternetConnectionException {
      return left(NoInternetConnectionFailure());
    } on BadRequestException catch (e) {
      return left(
          BadRequestFailure(errorCode: e.errorCode, message: e.errorMessage));
    } on RestApiException catch (e) {
      return left(Utils.handleRestApiException(e));
    } catch (e) {
      return left(Utils.handleUnknownException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTodo(TodoModel todoModel) async {
    try {
      final unit =
          await _todoDataSource.updateTodo(_todoMapper.mapToEntity(todoModel));

      return right(unit);
    } on NoInternetConnectionException {
      return left(NoInternetConnectionFailure());
    } on BadRequestException catch (e) {
      return left(
          BadRequestFailure(errorCode: e.errorCode, message: e.errorMessage));
    } on RestApiException catch (e) {
      return left(Utils.handleRestApiException(e));
    } catch (e) {
      return left(Utils.handleUnknownException(e));
    }
  }
}
