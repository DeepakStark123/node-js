import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:node_app/blocs_cubits/todo/todo_cubit.dart';
import 'package:node_app/models/todo_list_model.dart';
import 'package:node_app/utils/app_routers.dart';
import 'package:node_app/utils/my_preferences.dart';
import 'package:node_app/utils/utility.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();
  late TodoCubit todoCubit;
  List<TodoData> todoList = [];

  displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add To-Do'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: todoCubit.todoTitleController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: todoCubit.todoDescController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      todoCubit.createItem(context);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      todoCubit = BlocProvider.of<TodoCubit>(context);
      todoCubit.getUserId(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note Keeper"),
        actions: [
          ElevatedButton(
              onPressed: () {
                MyPreferences.logOut().then((value) {
                  if (value) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.loginScreenRoute, (route) => false);
                  }
                });
              },
              child: const Text("Logout")),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {
          if (state is TodoLoadedeState) {
            todoList.clear();
            todoList.addAll(state.todoList);
          }
          if (state is TodoDetetedSuccessState) {
            Utility.showCustomSnackbar(context, "Item Deleted", duration: 1);
          }
        },
        builder: (context, state) {
          if (state is TodoLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.all(Utility.customPadding),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: todoList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(todoList[index].title ?? ""),
                                    Text(todoList[index].description ?? ""),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // IconButton(
                                    //     onPressed: () {},
                                    //     icon: const Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          todoCubit.deleteItem(
                                            context,
                                            todoList[index].id.toString(),
                                          );
                                        },
                                        icon: const Icon(Icons.delete))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          displayTextInputDialog(context);
        },
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
