import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:node_app/blocs_cubits/signup/signup_cubit.dart';
import 'package:node_app/repos/login_repo.dart';
import 'package:node_app/repos/signup_repo.dart';
import 'package:node_app/repos/todo_repo.dart';
import '../blocs_cubits/login/login_cubit.dart';
import '../blocs_cubits/todo/todo_cubit.dart';

class Utility {
  static const double customPadding = 16;
  static const double customMargin = 16;
  //---All-Providers----
  static getAllProviders(BuildContext context) {
    return [
      BlocProvider<LoginCubit>(
        create: (BuildContext context) => LoginCubit(),
      ),
      BlocProvider<SignupCubit>(
        create: (BuildContext context) => SignupCubit(),
      ),
      BlocProvider<TodoCubit>(
        create: (BuildContext context) => TodoCubit(),
      ),
    ];
  }

  //---All-Repository----
  static getAllRepository() {
    return [
      RepositoryProvider<LoginRepo>(
        create: (context) => LoginRepo(),
      ),
      RepositoryProvider<SignUpRepo>(
        create: (context) => SignUpRepo(),
      ),
      RepositoryProvider<TodoRepo>(
        create: (context) => TodoRepo(),
      ),
    ];
  }

  //---CustomSnackbar---
  static showCustomSnackbar(BuildContext context, String message,
      {bool isSuccess = true, int duration = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        elevation: 4.0,
      ),
    );
  }
}
