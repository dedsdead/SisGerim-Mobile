import 'package:flutter/material.dart';
import 'package:sisgerim/src/component/text_field.dart';
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
  int _counter = 0;

  final _formKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void dispose() {
    _loginController.dispose();
    _senhaController.dispose();
    super.dispose();
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 50),
          child: Center(
            child: Column(
              children: <Widget>[
                FormTextField(
                  controller: _loginController,
                  hintName: "Login",
                  icon: Icons.person_outline,
                  inputType: TextInputType.text,
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
                        // TODO: CONECTAR AO BACKEND NA ROTA DE LOGIN
                        MessageApp.toastMesssage(
                          context,
                          MessageApp.errorWrongLoginPassword,
                        );
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
                        const route = RouteSettings(name: RoutesApp.signUp);
                        Navigator.pushAndRemoveUntil(context,
                            RoutesApp.generateRoute(route), (route) => false);
                      },
                      child: const Text("Cadastre-se"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
