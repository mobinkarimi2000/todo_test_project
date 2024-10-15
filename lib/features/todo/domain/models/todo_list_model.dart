import 'todo_model.dart';

class TodoListModel {
  List<TodoModel>? todos;
  int? total;
  int? skip;
  int? limit;

  TodoListModel({this.todos, this.total, this.skip, this.limit});

  factory TodoListModel.fromJson(Map<String, dynamic> json) => TodoListModel(
        todos: (json['todos'] as List<dynamic>?)
            ?.map((e) => TodoModel.fromJson(e as Map<String, dynamic>))
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
