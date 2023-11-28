import 'dart:convert';
import 'dart:io';

abstract class IHttpClient {
  Future postLogin(
      {required String url, required String login, required String password});
  Future getClients(
      {required String url, required String corretorId, required String token});
}

class HttpServerClient implements IHttpClient {
  @override
  Future postLogin(
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

  @override
  Future getClients(
      {required String url,
      required String corretorId,
      required String token}) async {
    HttpClient httpClient = HttpClient();
    url = '$url/$corretorId';
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    request.headers.set('Authorization', 'Bearer $token');
    HttpClientResponse response = await request.close();
    httpClient.close();
    return response;
  }
}
