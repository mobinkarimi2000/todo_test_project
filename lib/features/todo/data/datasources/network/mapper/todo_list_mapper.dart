import 'package:todo_test_project/core/mapper/mapper.dart';
import 'package:todo_test_project/features/todo/data/datasources/network/dto/todo_list_dto.dart';
import 'package:todo_test_project/features/todo/domain/models/todo_list_model.dart';

class TodoListMapper extends EntityMapper<TodoListDto, TodoListModel> {
  @override
  TodoListModel mapFromEntity(TodoListDto entity) {
    return TodoListModel.fromJson(entity.toJson());
  }

  @override
  TodoListDto mapToEntity(TodoListModel domainModel) {
    return TodoListDto.fromJson(domainModel.toJson());
  }
}
