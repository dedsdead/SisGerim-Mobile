// import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

abstract class IHttpClient {
  Future post(
      {required String url, required String login, required String password});
}

class HttpServerClient implements IHttpClient {
  // final client = http.Client();
  @override
  Future post(
      {required String url,
      required String login,
      required String password}) async {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('Content-type', 'application/json');
    request.add(utf8.encode(json.encode({'email': login, 'senha': password})));
    HttpClientResponse response = await request.close();
    httpClient.close();
    return response;
  }
}
