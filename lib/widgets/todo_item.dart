import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/item_model.dart';
import 'package:todo_app/providers/todo_provider.dart';

class TodoItem extends ConsumerWidget {
  final ItemModel todo;
  final Function onTodoChange;
  final Function onTodoDelete;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onTodoChange,
    required this.onTodoDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemProvider = ref.watch(todoProvider);
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () => onTodoChange(),
        title: Text(
          todo.text,
          style: TextStyle(
              decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: todo.isDone
            ? const Icon(Icons.check_box)
            : const Icon(Icons.check_box_outline_blank),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => onTodoDelete()),
        ),
      ),
    );
  }
}
