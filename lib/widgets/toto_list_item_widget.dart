import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notebook_riverpod/models/todo_model.dart';
import 'package:notebook_riverpod/providers/all_providers.dart';

class ToDoListItemWidget extends ConsumerStatefulWidget {
  ToDoListItemWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ToDoListItemWidget> createState() => _ToDoListItemWidgetState();
}

class _ToDoListItemWidgetState extends ConsumerState<ToDoListItemWidget> {
  late FocusNode _textFocusNode;
  late TextEditingController _textcontroller;
  bool _hasFocus = false;


  @override
  void initState() {
    super.initState();
    _textFocusNode = FocusNode();
    _textcontroller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textFocusNode.dispose();
    _textcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTodoItem = ref.watch(currentToDo);
    return Focus(
      onFocusChange: (isFocused)
      {
        if (!isFocused)
          {
            setState(() {
              _hasFocus = false;
            });
            ref.read(todoListProvider.notifier).updateTodo(TodoModel(
                id: currentTodoItem.id, description: _textcontroller.text));
          }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            _hasFocus = true;
            _textFocusNode.requestFocus();
            _textcontroller.text = currentTodoItem.description;
          });
        },
        leading: Checkbox(
          value: currentTodoItem.completed, // Access item through widget
          onChanged: (value) {
            ref.read(todoListProvider.notifier).toggleTodo(currentTodoItem.id);
          },
        ),
        title: _hasFocus
            ? TextField(
          controller: _textcontroller,
          focusNode: _textFocusNode,
        )
            : Text(currentTodoItem.description),
      ),
    );
  }
}
