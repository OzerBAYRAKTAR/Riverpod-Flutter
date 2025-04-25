

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notebook_riverpod/models/todo_model.dart';
import 'package:uuid/uuid.dart';


class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(TodoModel todo) {
    state = [...state, todo];
  }

  void removeTodo(TodoModel model) {
    state = state.where((todo) => todo.id != model.id).toList();
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
  int onCompletedToDoCount() {
    return state.where((element) => !element.completed).length;
  }
}