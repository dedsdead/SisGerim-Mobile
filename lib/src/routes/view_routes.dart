import 'package:flutter/material.dart';
import 'package:sisgerim/src/views/home.dart';
import 'package:sisgerim/src/views/login.dart';

class RoutesApp {
  static const login = '/';
  static const home = '/home';
  static const signUp = '/signup';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
            builder: (context) => const LoginPage(
                  title: "Login",
                ));
      case home:
        return MaterialPageRoute(
            builder: (context) => const HomePage(
                  title: "Home",
                ));
      case signUp:
        return MaterialPageRoute(
            builder: (context) => const LoginPage(
                  title: "Sign Up",
                ));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("ERRO"),
        ),
      );
    });
  }
}
