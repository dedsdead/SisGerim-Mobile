import 'package:sisgerim/src/http/http_client_post.dart';
import 'dart:convert';

abstract class ILoginRepository {
  Future<String> getToken({required String login, required String password});
}

class LoginRepository implements ILoginRepository {
  final IHttpClient client;

  LoginRepository({required this.client});

  @override
  Future<String> getToken(
      {required String login, required String password}) async {
    final response = await client.post(
      url: "http://192.168.0.6:8080/api/auth/login",
      login: login,
      password: password,
    );

    if (response.statusCode == 403) {
      return "wrong login or password";
    } else if (response.statusCode == 202) {
      String reply = await response.transform(utf8.decoder).join();
      return reply;
    } else {
      return "server error";
    }
  }
}
