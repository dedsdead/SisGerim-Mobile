import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisgerim/src/component/text_field.dart';
import 'package:sisgerim/src/http/http_client_post.dart';
import 'package:sisgerim/src/repositories/login_repository.dart';
import 'package:sisgerim/src/routes/view_routes.dart';
import 'package:sisgerim/src/utils/message.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _token;

  final LoginRepository _repository = LoginRepository(
    client: HttpServerClient(),
  );

  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();

  Future<void> _setToken(String token) async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _token = prefs.setString('token', token).then((bool success) {
        return token;
      });
    });
  }

  @override
  void dispose() {
    _loginController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _token = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('token') ?? "";
    });
    // if (_token.toString() != "") {
    //   var route = const RouteSettings(
    //     name: RoutesApp.home,
    //   );
    //   Navigator.pushAndRemoveUntil(
    //       context, RoutesApp.generateRoute(route), (route) => false);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the LoginPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder<String>(
        future: _token,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          FormTextField(
                            controller: _loginController,
                            hintName: "E-mail",
                            icon: Icons.mail_outline,
                            inputType: TextInputType.emailAddress,
                          ),
                          FormTextField(
                            controller: _senhaController,
                            hintName: "Senha",
                            icon: Icons.lock_outline,
                            inputType: TextInputType.visiblePassword,
                            isObscured: true,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 30, left: 150, right: 150, bottom: 30),
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await _repository
                                      .getToken(
                                    login: _loginController.text,
                                    password: _senhaController.text,
                                  )
                                      .then((reply) {
                                    if (reply == "wrong login or password") {
                                      MessageApp.toastMessage(
                                        context,
                                        MessageApp.errorWrongLoginPassword,
                                      );
                                    } else if (reply == "server error") {
                                      MessageApp.toastMessage(
                                        context,
                                        MessageApp.serverError,
                                      );
                                    } else {
                                      _setToken(reply);
                                      var route = const RouteSettings(
                                        name: RoutesApp.home,
                                      );
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        RoutesApp.generateRoute(route),
                                        (route) => false,
                                      );
                                    }
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                              ),
                              child: const Text("Login"),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text("Não possui uma conta?"),
                              TextButton(
                                onPressed: () {
                                  const route =
                                      RouteSettings(name: RoutesApp.signUp);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      RoutesApp.generateRoute(route),
                                      (route) => false);
                                },
                                child: const Text("Cadastre-se"),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
