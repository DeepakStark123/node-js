import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:node_app/blocs_cubits/login/login_cubit.dart';
import 'package:node_app/utils/app_routers.dart';
import 'package:node_app/utils/utility.dart';
import 'package:node_app/widgets/custom_logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Utility.showCustomSnackbar(context, "Login Successful");
            });
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.homeScreenRoute, (route) => false);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(Utility.customPadding),
            child: Form(
              key: formKey,
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
                      controller: loginCubit.emailController,
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
                          onPressed: () {},
                          icon: const Icon(Icons.email),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: loginCubit.passwordController,
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
                          onPressed: () {},
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
                            loginCubit.loginUser(context);
                          }
                        },
                        child: (state is LoginLoadingState)
                            ? const Text('Loading...')
                            : const Text('Loged-In'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.signUpScreenRoute,
                        );
                      },
                      child: const Text(
                        "Create a new Account..! SignUp",
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
