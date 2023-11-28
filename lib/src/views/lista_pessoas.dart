import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisgerim/src/http/http_client_post.dart';
import 'package:sisgerim/src/model/cliente.dart';
import 'package:sisgerim/src/model/corretor.dart';
import 'package:sisgerim/src/repositories/cliente_repository.dart';

class PersonListView extends StatefulWidget {
  PersonListView({
    super.key,
    required this.title,
  });

  final String title;
  late Map<int, Corretor> corretores;

  @override
  State<StatefulWidget> createState() => _PersonListViewState();
}

class _PersonListViewState extends State<PersonListView> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _token;
  late String _corretorId;
  late Map<String, dynamic> _id;
  late List<dynamic> clientesList;
  late List<Cliente> corretoresList;

  late Future<Map<int, Cliente>> _clientes;

  final ClienteRepository _repository = ClienteRepository(
    client: HttpServerClient(),
  );

  @override
  void initState() {
    super.initState();
    _token = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('token') ?? "";
    });
    _clientes = getClientes("corretorId", "token");
  }

  Future<Map<int, Cliente>> getClientes(String corretorId, String token) async {
    String reply = await _repository
        .getClientes(corretorId: corretorId, token: token)
        .then((reply) => reply);

    if (reply == "[]") {
      print("empty list");
      clientesList = List.empty();
    } else if (reply == "error authenticating") {
      print(reply);
      clientesList = List.empty();
    } else if (reply == "server error") {
      print(reply);
      clientesList = List.empty();
    } else {
      print(reply);
      clientesList = List.empty();
      clientesList =
          jsonDecode(reply).map((data) => Cliente.fromJson(data)).toList();
      _clientes
          .then((value) => value.addAll(clientesList as Map<int, Cliente>));
    }

    return _clientes;
  }

  // void _removeCliente(int index) {
  //   setState(() {
  //     widget.clientes.remove(index);
  //   });
  // }

  void _removeCorretor(int index) {
    setState(() {
      widget.corretores.remove(index);
    });
  }

  // void _transformCliente(int index, cliente) {
  //   if (cliente != null) {
  //     cliente as Cliente;
  //     setState(() {
  //       widget.clientes.update(index, (value) => cliente);
  //     });
  //   }
  // }

  void _transformCorretor(int index, corretor) {
    if (corretor != null) {
      corretor as Corretor;
      setState(() {
        widget.corretores.update(index, (value) => corretor);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FutureBuilder(
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
                    _id = JwtDecoder.decode(snapshot.data!);
                    _corretorId = _id["corretorId"];
                    getClientes(_corretorId, snapshot.data!);
                    return Text("ok");
                    // return FutureBuilder(
                    //     future: _clientes,
                    //     builder: (BuildContext context,
                    //         AsyncSnapshot<Map<int, Cliente>> snapshot) {
                    //       switch (snapshot.connectionState) {
                    //         case ConnectionState.none:
                    //         case ConnectionState.waiting:
                    //           return const Center(
                    //             child: CircularProgressIndicator(),
                    //           );
                    //         case ConnectionState.active:
                    //         case ConnectionState.done:
                    //           if (snapshot.hasError) {
                    //             return Text('Error: ${snapshot.error}');
                    //           } else {
                    //             return ListView.builder(
                    //               shrinkWrap: true,
                    //               itemCount: snapshot.data!.length,
                    //               itemBuilder: (context, index) {
                    //                 return Card(
                    //                   elevation: 0.0,
                    //                   child: ExpansionTile(
                    //                     title: Text(
                    //                       "${snapshot.data!.values.elementAt(index).id}: ${snapshot.data!.values.elementAt(index).nome}",
                    //                       style: const TextStyle(
                    //                         fontWeight: FontWeight.bold,
                    //                         fontSize: 18,
                    //                         color: Colors.black,
                    //                       ),
                    //                     ),
                    //                     subtitle: Text(snapshot.data!.values
                    //                         .elementAt(index)
                    //                         .email),
                    //                     children: <Widget>[
                    //                       Row(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.spaceAround,
                    //                         children: <Widget>[
                    //                           TextButton.icon(
                    //                               onPressed: () async {
                    //                                 // TODO: redirect to client editing page
                    //                                 // await Navigator.of(context)
                    //                                 // .pushNamed(
                    //                                 //   RoutesApp.listarPessoas,
                    //                                 //   arguments: ScreenArguments(
                    //                                 //     widget.clientes.values.elementAt(index),
                    //                                 //     widget.clientes.keys.elementAt(index),
                    //                                 //   ),
                    //                                 // )
                    //                                 //
                    //                                 //.then( (cliente) =>
                    //                                 //_transformCliente(widget.clientes.keys.elementAt(index), value,),);
                    //                               },
                    //                               icon: Icon(
                    //                                 Icons.edit,
                    //                                 color:
                    //                                     Colors.amber.shade600,
                    //                               ),
                    //                               label: Text("Editar",
                    //                                   style: TextStyle(
                    //                                       color: Colors.amber
                    //                                           .shade600))),
                    //                           TextButton.icon(
                    //                               onPressed: () {
                    //                                 showDialog(
                    //                                   context: context,
                    //                                   builder: (context) =>
                    //                                       AlertDialog(
                    //                                     title: const Text(
                    //                                         'Excluir Cliente'),
                    //                                     content: Text(
                    //                                         'Tem certeza que deseja excluir o cliente ${snapshot.data!.values.elementAt(index).nome}?'),
                    //                                     actions: <Widget>[
                    //                                       SimpleDialogOption(
                    //                                         child: const Text(
                    //                                             'Não'),
                    //                                         onPressed: () {
                    //                                           Navigator.pop(
                    //                                               context);
                    //                                         },
                    //                                       ),
                    //                                       SimpleDialogOption(
                    //                                         child: const Text(
                    //                                             'Sim'),
                    //                                         onPressed: () {
                    //                                           // TODO: implement http delete cliente
                    //                                           // _removeUser(index);
                    //                                           // Navigator.pop(context);
                    //                                         },
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                 );
                    //                               },
                    //                               icon: const Icon(
                    //                                 Icons.edit,
                    //                                 color: Colors.pink,
                    //                               ),
                    //                               label: const Text("Excluir",
                    //                                   style: TextStyle(
                    //                                       color: Colors.pink))),
                    //                         ],
                    //                       )
                    //                     ],
                    //                   ),
                    //                 );
                    //               },
                    //             );
                    //           }
                    //       }
                    //     });
                  }
              }
            }),

        // ListView.builder(
        //   shrinkWrap: true,
        //   itemCount: widget.corretores.length,
        //   itemBuilder: (context, index) {
        //     return Card(
        //       elevation: 0.0,
        //       child: ExpansionTile(
        //         title: Text(
        //           "${widget.corretores.values.elementAt(index).id}: ${widget.corretores.values.elementAt(index).nome}",
        //           style: const TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 18,
        //             color: Colors.black,
        //           ),
        //         ),
        //         subtitle: Text(widget.corretores.values.elementAt(index).email),
        //         children: <Widget>[
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceAround,
        //             children: <Widget>[
        //               TextButton.icon(
        //                   onPressed: () async {
        //                     // TODO: redirect to broker editing page
        //                   },
        //                   icon: Icon(
        //                     Icons.edit,
        //                     color: Colors.amber.shade600,
        //                   ),
        //                   label: Text("Editar",
        //                       style: TextStyle(color: Colors.amber.shade600))),
        //               TextButton.icon(
        //                   onPressed: () {
        //                     showDialog(
        //                       context: context,
        //                       builder: (context) => AlertDialog(
        //                         title: const Text('Excluir Corretor'),
        //                         content: Text(
        //                             'Tem certeza que deseja excluir o cliente ${widget.corretores.values.elementAt(index).nome}?'),
        //                         actions: <Widget>[
        //                           SimpleDialogOption(
        //                             child: const Text('Não'),
        //                             onPressed: () {
        //                               Navigator.pop(context);
        //                             },
        //                           ),
        //                           SimpleDialogOption(
        //                             child: const Text('Sim'),
        //                             onPressed: () {
        //                               // UserBox.getUsersBox().deleteAt(
        //                               //     widget.users.keys.elementAt(index));
        //                               // _removeUser(index);
        //                               // Navigator.pop(context);
        //                             },
        //                           ),
        //                         ],
        //                       ),
        //                     );
        //                   },
        //                   icon: const Icon(
        //                     Icons.edit,
        //                     color: Colors.pink,
        //                   ),
        //                   label: const Text("Excluir",
        //                       style: TextStyle(color: Colors.pink))),
        //             ],
        //           )
        //         ],
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}
