// final todoListModel = todoListModelFromJson(jsonString);

import 'dart:convert';

TodoListModel todoListModelFromJson(String str) =>
    TodoListModel.fromJson(json.decode(str));

String todoListModelToJson(TodoListModel data) => json.encode(data.toJson());

class TodoListModel {
  bool? status;
  String? error;
  List<TodoData>? todoDataList;
  TodoListModel({
    this.status,
    this.error,
    this.todoDataList,
  });

  factory TodoListModel.fromJson(Map<String, dynamic> json) => TodoListModel(
        status: json["status"],
        error: json["error"],
        todoDataList: json["success"] == null
            ? []
            : List<TodoData>.from(
                json["success"]!.map((x) => TodoData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "success": todoDataList == null
            ? []
            : List<dynamic>.from(todoDataList!.map((x) => x.toJson())),
      };
}

class TodoData {
  String? id;
  String? userId;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  TodoData({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TodoData.fromJson(Map<String, dynamic> json) => TodoData(
        id: json["_id"],
        userId: json["userId"],
        title: json["title"],
        description: json["description"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "title": title,
        "description": description,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
