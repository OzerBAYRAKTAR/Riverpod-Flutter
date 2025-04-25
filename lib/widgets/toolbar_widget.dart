import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notebook_riverpod/providers/all_providers.dart';

class ToolBarWidget extends ConsumerWidget {
  ToolBarWidget({Key? key}) : super(key: key);

  var _currentFilter = TodolistFilter.all;


  Color changeTextcolor(TodolistFilter filt){
    return _currentFilter == filt ? Colors.orange : Colors.black;
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oncompletedCount = ref.watch(unCompletedTodoCount);
    _currentFilter = ref.watch(todoListFilter);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            oncompletedCount == 0
                ? 'Tüm görevler OK'
                : oncompletedCount.toString() + ' görev tamamlanmadı',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Tooltip(
          message: 'All Todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: changeTextcolor(TodolistFilter.all)
              ),
              onPressed: () {
            ref.read(todoListFilter.notifier).state = TodolistFilter.all;
          }, child: const Text('All')),
        ),
        Tooltip(
          message: 'Only Uncompleted Todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: changeTextcolor(TodolistFilter.active)
              ),
              onPressed: () {
            ref.read(todoListFilter.notifier).state = TodolistFilter.active;
          }, child: const Text('Active')),
        ),
        Tooltip(
          message: 'Only Completed Todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: changeTextcolor(TodolistFilter.completed)
              ),
              onPressed: () {
            ref.read(todoListFilter.notifier).state = TodolistFilter.completed;
          }, child: const Text('Completed')),
        ),
      ],
    );
  }
}
