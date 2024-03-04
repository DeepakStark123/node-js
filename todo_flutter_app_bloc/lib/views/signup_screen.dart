import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:node_app/blocs_cubits/signup/signup_cubit.dart';
import 'package:node_app/utils/app_routers.dart';
import 'package:node_app/utils/utility.dart';

import '../widgets/custom_logo.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final signUpCubit = BlocProvider.of<SignupCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
      ),
      body: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Utility.showCustomSnackbar(context, "User Register Successfully");
            });
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.loginScreenRoute, (route) => false);
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Padding(
              padding: const  EdgeInsets.all(Utility.customPadding),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CommonLogo(),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                      controller: signUpCubit.emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        labelText: 'Email',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 16),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        prefixIcon: IconButton(
                          onPressed: () {
                            var pass = signUpCubit.generatePassword(
                              signUpCubit.passwordController.text,
                            );
                            signUpCubit.passwordController.text = pass;
                          },
                          icon: const Icon(Icons.email),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: signUpCubit.passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 16),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        prefixIcon: IconButton(
                          onPressed: () {
                            var pass = signUpCubit.generatePassword(
                              signUpCubit.passwordController.text,
                            );
                            signUpCubit.passwordController.text = pass;
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            signUpCubit.signupUser(context);
                          }
                        },
                        child: (state is SignupLoadingState)
                            ? const Text('registering...')
                            : const Text('Sign-Up'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Already Registered? SignIn",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
