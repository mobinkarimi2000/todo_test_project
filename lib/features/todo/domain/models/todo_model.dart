class TodoModel {
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  TodoModel({this.id, this.todo, this.completed, this.userId});

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
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
