import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_flutter_app/views/home_screen.dart';
import 'package:todo_flutter_app/views/signIn_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    token: prefs.getString('token'),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({this.token, Key? key}) : super(key: key);
  final String? token;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TodoApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (token != null && JwtDecoder.isExpired(token ?? "") == false)
          ? HomeScreen(token: token ?? "")
          : const SignInPage(),
    );
  }
}
