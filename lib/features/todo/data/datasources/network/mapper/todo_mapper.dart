import 'package:todo_test_project/core/mapper/mapper.dart';
import 'package:todo_test_project/features/todo/data/datasources/network/dto/todo_dto.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_model.dart';

class TodoMapper extends EntityMapper<TodoDto, TodoModel> {
  @override
  TodoModel mapFromEntity(TodoDto entity) {
    return TodoModel.fromJson(entity.toJson());
  }

  @override
  TodoDto mapToEntity(TodoModel domainModel) {
    return TodoDto.fromJson(domainModel.toJson());
  }
}
