import 'package:dartz/dartz.dart';
import 'package:todo_test_project/core/error_handling/failure.dart';
import 'package:todo_test_project/core/usecase/use_case.dart';
import 'package:todo_test_project/features/todo/domain/repositories/todo_repository.dart';

class DeleteTodoListUseCase extends UseCase<Either<Failure, Unit>, int> {
  final TodoRepository _todoRepository;

  DeleteTodoListUseCase(this._todoRepository);
  @override
  Future<Either<Failure, Unit>> call(int input) {
    return _todoRepository.deleteTodo(input);
  }
}
