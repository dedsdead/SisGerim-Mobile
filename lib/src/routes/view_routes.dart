import 'package:flutter/material.dart';
import 'package:sisgerim/src/views/home.dart';
import 'package:sisgerim/src/views/lista_pessoas.dart';
import 'package:sisgerim/src/views/login.dart';

class RoutesApp {
  static const login = '/';
  static const signUp = '/signup';
  static const home = '/home';
  static const listarPessoas = '/listarpessoas';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
            builder: (context) => const LoginPage(
                  title: "Login",
                ));
      case signUp:
        return MaterialPageRoute(
            builder: (context) => const LoginPage(
                  title: "Sign Up",
                ));
      case home:
        return MaterialPageRoute(
            builder: (context) => const HomePage(
                  title: "Home",
                ));
      case listarPessoas:
        return MaterialPageRoute(
            builder: (context) => PersonListView(
                  title: "Listar Pessoas",
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
