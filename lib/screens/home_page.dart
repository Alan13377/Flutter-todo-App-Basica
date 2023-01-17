import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/widgets/todo_item.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemController = ref.watch(todoProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: customAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                searchBox(itemController),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "TODO APP",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: ListView.builder(
                      itemCount: itemController.foundTodo.length,
                      itemBuilder: ((context, index) {
                        final todo = itemController.foundTodo;
                        return TodoItem(
                          todo: todo[index],
                          onTodoChange: () {
                            itemController.onTodoChange(todo[index]);
                          },
                          onTodoDelete: () {
                            itemController.onDelete(todo[index]);
                          },
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      right: 20,
                      left: 20,
                      bottom: 40,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 2,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: itemController.todoController,
                      decoration: const InputDecoration(
                        hintText: "Añadir tarea",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    right: 20,
                    bottom: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      itemController.onSave(
                        itemController.todoController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigoAccent,
                        minimumSize: const Size(
                          60,
                          60,
                        ),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        )),
                    child: const Text(
                      "+",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container searchBox(itemController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: TextField(
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          contentPadding: EdgeInsets.all(0),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
        onChanged: ((value) {
          itemController.search(value);
        }),
      ),
    );
  }

  AppBar customAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: const [
          Icon(
            Icons.menu,
            color: Colors.black,
          ),
          Spacer(),
          CircleAvatar(),
        ],
      ),
    );
  }
}
