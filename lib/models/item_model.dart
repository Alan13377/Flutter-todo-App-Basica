// ignore_for_file: public_member_api_docs, sort_constructors_first

class ItemModel {
  String id;
  String text;
  bool isDone;

  ItemModel({
    required this.id,
    required this.text,
    this.isDone = false,
  });

  static List<ItemModel> todoList() {
    return [
      ItemModel(id: "01", text: "Primera Tarea", isDone: true),
      ItemModel(id: "02", text: "Segunda Tarea"),
      ItemModel(id: "03", text: "Tercera Tarea", isDone: true),
      ItemModel(id: "04", text: "Cuarta Tarea"),
    ];
  }
}
