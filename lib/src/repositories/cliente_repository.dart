import 'package:sisgerim/src/http/http_client_post.dart';
import 'dart:convert';

abstract class IClienteRepository {
  Future<String> getClientes(
      {required String corretorId, required String token});
}

class ClienteRepository implements IClienteRepository {
  final IHttpClient client;

  ClienteRepository({required this.client});

  @override
  Future<String> getClientes(
      {required String corretorId, required String token}) async {
    final response = await client.getClients(
      url: "http://192.168.0.6:8080/api/cliente",
      corretorId: corretorId,
      token: token,
    );

    if (response.statusCode == 403) {
      return "error authenticating";
    } else if (response.statusCode == 200) {
      String reply = await response.transform(utf8.decoder).join();
      return reply;
    } else {
      return "server error";
    }
  }
}
