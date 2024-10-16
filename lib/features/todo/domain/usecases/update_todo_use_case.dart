import 'package:dartz/dartz.dart';
import 'package:todo_test_project/core/error_handling/failure.dart';
import 'package:todo_test_project/core/usecase/use_case.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_model.dart';
import 'package:todo_test_project/features/todo/domain/repositories/todo_repository.dart';

class UpdateTodoListUseCase extends UseCase<Either<Failure, Unit>, TodoModel> {
  final TodoRepository _todoRepository;

  UpdateTodoListUseCase(this._todoRepository);
  @override
  Future<Either<Failure, Unit>> call(TodoModel input) {
    return _todoRepository.updateTodo(input);
  }
}
