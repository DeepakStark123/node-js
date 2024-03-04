import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:node_app/models/todo_list_model.dart';
import 'package:node_app/repos/todo_repo.dart';
import 'package:node_app/utils/my_preferences.dart';
part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoLoadingState());
  final TextEditingController todoTitleController = TextEditingController();
  final TextEditingController todoDescController = TextEditingController();
  String userId = '';

  getUserId(BuildContext context) {
    emit(TodoLoadingState());
    var token = MyPreferences.getToken();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);
    userId = jwtDecodedToken['_id'];
    debugPrint("Userid==> $userId");
    fetchNotes(userId, context);
  }

  fetchNotes(String userId, BuildContext context) async {
    var myTodoList = await TodoRepo.fetchData(userId, context);
    if (myTodoList != null) {
      emit(TodoLoadedeState(todoList: myTodoList));
    } else {
      emit(TodoErrorState());
    }
  }

  createItem(BuildContext context) async {
    emit(TodoLoadingState());
    var isCreated = await TodoRepo.createTodoItem(
        userId,
        todoTitleController.text.trim(),
        todoDescController.text.trim(),
        context);
    if (isCreated == true) {
      todoTitleController.clear();
      todoDescController.clear();
      emit(TodoCreateSuccessState());
      // ignore: use_build_context_synchronously
      getUserId(context);
    } else {
      emit(TodoErrorState());
    }
  }

  deleteItem(BuildContext context, String id) async {
    emit(TodoLoadingState());
    var isDeleted = await TodoRepo.deleteTodoItem(id, context);
    if (isDeleted == true) {
      emit(TodoDetetedSuccessState());
      // ignore: use_build_context_synchronously
      getUserId(context);
    } else {
      emit(TodoErrorState());
    }
  }
}
