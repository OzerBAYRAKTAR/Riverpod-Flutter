

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notebook_riverpod/models/todo_model.dart';
import 'package:uuid/uuid.dart';

final todoListProvider = StateNotifierProvider<TodoListManager, List<TodoModel>>(
      (ref) => TodoListManager([
    TodoModel(id: const Uuid().v4(), description: 'Spora Git'),
    TodoModel(id: const Uuid().v4(), description: 'Marekete Git'),
  ]),
);
class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(TodoModel todo) {
    state = [...state, todo];
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void toggleTodo(String id) {
    state = state
        .map((todo) => todo.id == id
        ? todo.copyWith(completed: !todo.completed)
        : todo)
        .toList();
  }

  void updateTodo(TodoModel updatedTodo) {
    state = state
        .map((todo) => todo.id == updatedTodo.id ? updatedTodo : todo)
        .toList();
  }
}