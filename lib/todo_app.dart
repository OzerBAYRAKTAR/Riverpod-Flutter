import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notebook_riverpod/future_provider_page.dart';
import 'package:notebook_riverpod/models/todo_model.dart';
import 'package:notebook_riverpod/providers/all_providers.dart';
import 'package:notebook_riverpod/widgets/title_widget.dart';
import 'package:notebook_riverpod/widgets/toolbar_widget.dart';
import 'package:notebook_riverpod/widgets/toto_list_item_widget.dart';
import 'package:uuid/uuid.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({Key? key}) : super(key: key);

  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const TitleWidget(),
                  TextField(
                    controller: newTodoController,
                    decoration: const InputDecoration(
                      labelText: 'Neler Yapacaksın Bugün ?',
                    ),
                    onSubmitted: (newTodo) {
                      final todo = TodoModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        description: newTodo,
                      );
                      ref.read(todoListProvider.notifier).addTodo(todo);
                      newTodoController.clear();
                    },
                  ),
                  const SizedBox(height: 20),
                  ToolBarWidget(),
                  const SizedBox(height: 10),
                  if (allTodos.isEmpty)
                    const Center(child: Text('Mevcut görev bulunamadı')),
                  for (var i = 0; i < allTodos.length; i++)
                    Dismissible(
                      key: ValueKey(allTodos[i].id),
                      onDismissed: (_) {
                        ref.read(todoListProvider.notifier).removeTodo(allTodos[i]);
                      },
                      child: ProviderScope(
                        overrides: [
                          currentToDo.overrideWithValue(allTodos[i]),
                        ],
                        child: ToDoListItemWidget(),
                      ),
                    ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FutureProviderExample(),
                ));
              },
              child: const Text('Future Provider Example'),
            ),
          ],
        ),
      ),
    );
  }
}
