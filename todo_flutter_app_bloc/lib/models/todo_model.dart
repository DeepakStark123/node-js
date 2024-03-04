// To parse this JSON data, do
//
//     final TodoModel = TodoModelFromJson(jsonString);

import 'dart:convert';

TodoModel todoModelFromJson(String str) => TodoModel.fromJson(json.decode(str));

String todoModelToJson(TodoModel data) => json.encode(data.toJson());

class TodoModel {
  bool? status;
  bool? error;
  Success? success;

  TodoModel({
    this.status,
    this.error,
    this.success,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        status: json["status"],
        error: json["error"],
        success:
            json["success"] == null ? null : Success.fromJson(json["success"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "success": success?.toJson(),
      };
}

class Success {
  String? userId;
  String? title;
  String? description;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Success({
    this.userId,
    this.title,
    this.description,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        userId: json["userId"],
        title: json["title"],
        description: json["description"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "title": title,
        "description": description,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
