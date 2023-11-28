import 'package:flutter/material.dart';
import 'package:sisgerim/src/routes/view_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton.icon(
                onPressed: () {
                  var route = const RouteSettings(
                    name: RoutesApp.listarPessoas,
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    RoutesApp.generateRoute(route),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.person, size: 80),
                label: const Text("Pessoas")),
            TextButton.icon(
                onPressed: () {
                  setState(() {
                    // TODO: Load Imoveis
                  });
                },
                icon: const Icon(Icons.house, size: 80),
                label: const Text("Imóveis")),
            TextButton.icon(
                onPressed: () {
                  setState(() {
                    // TODO: Load Vendas
                  });
                },
                icon: const Icon(Icons.monetization_on, size: 80),
                label: const Text("Vendas")),
          ],
        ),
      ),
    );
  }
}
