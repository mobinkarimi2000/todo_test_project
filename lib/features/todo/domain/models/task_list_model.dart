import 'task_model.dart';

class TaskListModel {
  List<TaskModel>? todos;
  int? total;
  int? skip;
  int? limit;

  TaskListModel({this.todos, this.total, this.skip, this.limit});

  factory TaskListModel.fromJson(Map<String, dynamic> json) => TaskListModel(
        todos: (json['todos'] as List<dynamic>?)
            ?.map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
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
