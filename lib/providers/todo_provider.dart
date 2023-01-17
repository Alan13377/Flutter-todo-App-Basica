import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/item_model.dart';

final todoProvider = ChangeNotifierProvider((ref) => TodoProvider());

class TodoProvider extends ChangeNotifier {
  List<ItemModel> _todoList = ItemModel.todoList();
  List<ItemModel> _foundTodo = [];
  TextEditingController _todoController = TextEditingController();

  List<ItemModel> get foundTodo => _foundTodo;
  List<ItemModel> get todoList => _todoList;
  TextEditingController get todoController => _todoController;

  TodoProvider() {
    init();
  }

  set todoList(List<ItemModel> todoList) {
    _todoList = todoList;
  }

  set foundTodo(List<ItemModel> foundTodo) {
    _foundTodo = foundTodo;
  }

  set todoController(TextEditingController todoController) {
    _todoController = todoController;
  }

  void init() {
    _foundTodo = todoList;
    notifyListeners();
  }

  void onSave(String todo) {
    if (todo.isNotEmpty) {
      todoList.add(
        ItemModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: todo,
        ),
      );
    }
    notifyListeners();
  }

  void onTodoChange(ItemModel todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
  }

  void onDelete(ItemModel id) {
    _foundTodo.remove(id);
    notifyListeners();
  }

  search(String enteredKeyword) {
    List<ItemModel> result;
    if (enteredKeyword.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where((element) =>
              element.text.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    _foundTodo = result;
    notifyListeners();
  }
}
