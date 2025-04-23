class TodoModel {
  final String id;
  final String description;
  final bool completed;

  TodoModel({required this.id, required this.description, this.completed=false});

  TodoModel copyWith({
    String? id,
    String? title,
    bool? completed,
  }) {
    return TodoModel(
      id: id ?? this.id,
      description: title ?? description,
      completed: completed ?? this.completed,
    );
  }
}