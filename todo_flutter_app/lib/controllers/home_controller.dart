import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:todo_flutter_app/utils/apis.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late String userId;
  TextEditingController todoTitle = TextEditingController();
  TextEditingController todoDesc = TextEditingController();
  RxList? items = <dynamic>[].obs;

  getData(String token) {
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);
    userId = jwtDecodedToken['_id'];
    debugPrint("Userid==> $userId");
    getTodoList(userId);
  }

  void addTodo() async {
    if (todoTitle.text.isNotEmpty && todoDesc.text.isNotEmpty) {
      var regBody = {
        "userId": userId,
        "title": todoTitle.text,
        "desc": todoDesc.text
      };
      var response = await http.post(
        Uri.parse(addtodo),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );
      debugPrint("response body  ==>${response.body}");
      debugPrint("response statuscode ==>${response.statusCode}");
      Map<String, dynamic> jsonResponse =
          await jsonDecode(response.body.toString());
      if (jsonResponse['status'] == true && response.statusCode == 200) {
        todoDesc.clear();
        todoTitle.clear();
        Get.back();
        getTodoList(userId);
      } else {
        debugPrint("SomeThing Went Wrong");
      }
    }
  }

  void getTodoList(userId) async {
    var regBody = {"userId": userId};
    var response = await http.post(
      Uri.parse(getToDoList),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    debugPrint("response body  ==>${response.body}");
    debugPrint("response statuscode ==>${response.statusCode}");
    Map<String, dynamic> jsonResponse =
        await jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      items!.value = jsonResponse['success'] ?? [];
    }
  }

  void deleteItem(id) async {
    var regBody = {"id": id};
    var response = await http.post(
      Uri.parse(deleteTodo),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    debugPrint("response body  ==>${response.body}");
    debugPrint("response statuscode ==>${response.statusCode}");
    Map<String, dynamic> jsonResponse =
        await jsonDecode(response.body.toString());
    if (jsonResponse['status'] == true && response.statusCode == 200) {
      getTodoList(userId);
    }
  }

  Future<void> displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add To-Do'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: todoTitle,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ).p4().px8(),
              TextField(
                controller: todoDesc,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ).p4().px8(),
              ElevatedButton(
                onPressed: () {
                  addTodo();
                },
                child: const Text("Add"),
              ),
            ],
          ),
        );
      },
    );
  }
}
