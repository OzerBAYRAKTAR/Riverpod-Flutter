import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notebook_riverpod/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

enum TodolistFilter {
  all,
  active,
  completed
}

final todoListFilter = StateProvider<TodolistFilter>((ref) =>
TodolistFilter.all);

final todoListProvider = StateNotifierProvider<TodoListManager,
    List<TodoModel>>(
      (ref) =>
      TodoListManager([
        TodoModel(id: const Uuid().v4(), description: 'Spora Git'),
        TodoModel(id: const Uuid().v4(), description: 'Marekete Git'),
        TodoModel(id: const Uuid().v4(), description: 'Okula Git'),
      ]),
);

final filteredTodoList = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todoList = ref.watch(todoListProvider);

  switch (filter) {
    case TodolistFilter.all:
      return todoList;
    case TodolistFilter.completed:
      return todoList.where((i) => i.completed).toList();
    case TodolistFilter.active:
      return todoList.where((i) => !i.completed).toList();
  }
});

final unCompletedTodoCount = Provider<int>((ref) {
  final allTodo = ref.watch(todoListProvider);
  final count = allTodo
      .where((i) => !i.completed)
      .length;
  return count;
});

final currentToDo = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});