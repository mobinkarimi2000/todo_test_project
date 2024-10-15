import 'package:dartz/dartz.dart';
import 'package:todo_test_project/core/error_handling/failure.dart';
import 'package:todo_test_project/core/usecase/use_case.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_list_model.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_list_params.dart';
import 'package:todo_test_project/features/todo/domain/repositories/todo_repository.dart';

class GetTodoListUseCase
    extends UseCase<Either<Failure, TodoListModel>, TodoListParams> {
  final TodoRepository _todoRepository;

  GetTodoListUseCase(this._todoRepository);
  @override
  Future<Either<Failure, TodoListModel>> call(TodoListParams input) {
    return _todoRepository.getTodoList(input);
  }
}
