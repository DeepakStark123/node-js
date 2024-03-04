import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:node_app/utils/my_preferences.dart';
import 'package:node_app/views/home_screen.dart';
import 'package:node_app/views/login_screen.dart';
import 'package:node_app/views/signup_screen.dart';

class AppRoutes {
  static String initialScreenRoute = "/";
  static String loginScreenRoute = "/login";
  static String signUpScreenRoute = "/signup";
  static String homeScreenRoute = "/home";

  static Map<String, WidgetBuilder> routes = {
    initialScreenRoute: (context) => _getInitialRoute(context),
    loginScreenRoute: (context) => const LoginScreen(),
    signUpScreenRoute: (context) => const SignUpScreen(),
    homeScreenRoute: (context) => const HomeScreen(),
  };

  static Widget _getInitialRoute(BuildContext context) {
    String token = MyPreferences.getToken();
    return (token != "" && JwtDecoder.isExpired(token) == false)
        ? const HomeScreen()
        : const LoginScreen();
  }

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final WidgetBuilder? builder = routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(
        builder: builder,
        settings: settings,
      );
    }
    return null;
  }
}
