import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:node_app/models/signup_model.dart';
import 'package:node_app/repos/signup_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //---Signup-User---
  signupUser(BuildContext context) async {
    emit(SignupLoadingState());
    SignUpModel? resp = await SignUpRepo.signUp(
        emailController.text.trim(), passwordController.text.trim(), context);
    if (resp != null) {
      emailController.clear();
      passwordController.clear();
      emit(SignupSuccessState());
    } else {
      emit(SignupErrorState());
    }
  }

  //---GeneratePassword----
  String generatePassword(String password) {
    if (password != "") {
      String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      String lower = 'abcdefghijklmnopqrstuvwxyz';
      String numbers = '1234567890';
      String symbols = '!@#\$%^&*()<>,./';
      String password = '';
      int passLength = 20;

      String seed = upper + lower + numbers + symbols;
      List<String> list = seed.split('').toList();
      Random rand = Random();

      for (int i = 0; i < passLength; i++) {
        int index = rand.nextInt(list.length);
        password += list[index];
      }
      return password;
    } else {
      return "";
    }
  }
}
