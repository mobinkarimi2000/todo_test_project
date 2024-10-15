import 'package:todo_test_project/features/todo/data/datasources/network/dto/todo_dto.dart';

class TodoListDto {
  List<TodoDto>? todos;
  int? total;
  int? skip;
  int? limit;

  TodoListDto({this.todos, this.total, this.skip, this.limit});

  factory TodoListDto.fromJson(Map<String, dynamic> json) => TodoListDto(
        todos: (json['todos'] as List<dynamic>?)
            ?.map((e) => TodoDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: json['total'] as int?,
        skip: json['skip'] as int?,
        limit: json['limit'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'todos': todos?.map((e) => e.toJson()).toList(),
        'total': total,
        'skip': skip,
        'limit': limit,
      };
}
