class TaskModel {
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  TaskModel({this.id, this.todo, this.completed, this.userId});

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'] as int?,
        todo: json['todo'] as String?,
        completed: json['completed'] as bool?,
        userId: json['userId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'todo': todo,
        'completed': completed,
        'userId': userId,
      };
}
