import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/login_model.dart';
import '../../repos/login_repo.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //---Login-User---
  loginUser(BuildContext context) async {
    emit(LoginLoadingState());
    LoginModel? resp = await LoginRepo.login(
        emailController.text.trim(), passwordController.text.trim(), context);
    if (resp != null) {
      emailController.clear();
      passwordController.clear();
      emit(LoginSuccessState());
    } else {
      emit(LoginErrorState());
    }
  }
}
