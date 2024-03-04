import 'package:node_app/models/todo_list_model.dart';
import 'package:node_app/models/todo_model.dart';
import 'package:node_app/utils/app_urls.dart';
import 'package:node_app/utils/utility.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class TodoRepo {
  static Future<List<TodoData>?> fetchData(
      String userId, BuildContext context) async {
    try {
      var body = {"userId": userId};
      debugPrint("Todo-Req-Body = $body");
      var res = await http.post(
        Uri.parse(AppUrls.getToDoList),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      debugPrint("Todo-StatusCode= ${res.statusCode}");
      debugPrint("Todo-Body = ${res.body}");
      if (res.statusCode == 200) {
        var todoModel = todoListModelFromJson(res.body.toString());
        if (todoModel.status == true) {
          return todoModel.todoDataList;
        } else {
          if (context.mounted) {
            Utility.showCustomSnackbar(
              context,
              todoModel.error.toString(),
              isSuccess: false,
            );
          }
          return null;
        }
      } else {
        debugPrint("FetchTodos failed with status code: ${res.statusCode}");
        return null;
      }
    } catch (e) {
      throw Exception("FetchTodos-Error:$e");
    }
  }

  ///----create-todo-item---
  static Future<bool> createTodoItem(
      String userId, String title, String desc, BuildContext context) async {
    try {
      var createBody = {"userId": userId, "title": title, "desc": desc};
      debugPrint("CreateTodo-Req-Body = $createBody");
      var res = await http.post(
        Uri.parse(AppUrls.addtodo),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(createBody),
      );
      debugPrint("create-Todo-StatusCode= ${res.statusCode}");
      debugPrint("create-Todo-Body = ${res.body}");
      if (res.statusCode == 200) {
        var todoModel = todoModelFromJson(res.body.toString());
        if (todoModel.status == true) {
          return true;
        } else {
          if (context.mounted) {
            Utility.showCustomSnackbar(
              context,
              todoModel.error.toString(),
              isSuccess: false,
            );
          }
          return false;
        }
      } else {
        debugPrint("CreateTodo failed with status code: ${res.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("CreateTodo-Exception:$e");
      return false;
    }
  }

  ///----delete-todo-item---
  static Future<bool> deleteTodoItem(
      String itemId, BuildContext context) async {
    try {
      var body = {"id": itemId};
      debugPrint("delete-Req-Body = $body");
      var res = await http.post(
        Uri.parse(AppUrls.deleteTodo),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      debugPrint("delete-Todo-StatusCode= ${res.statusCode}");
      debugPrint("delete-Todo-Body = ${res.body}");
      if (res.statusCode == 200) {
        var todoModel = todoModelFromJson(res.body.toString());
        if (todoModel.status == true) {
          return true;
        } else {
          if (context.mounted) {
            Utility.showCustomSnackbar(
              context,
              todoModel.error.toString(),
              isSuccess: false,
            );
          }
          return false;
        }
      } else {
        debugPrint("delete failed with status code: ${res.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("Delete-Exception:$e");
      return false;
    }
  }
}
