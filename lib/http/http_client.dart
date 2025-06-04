import 'dart:convert';

import 'package:finance/cfg/security.dart';
import 'package:finance/http/error_client.dart';
import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future<dynamic> get(String url, {Map<String, String>? headers});
  Future<dynamic> post(String url, dynamic body);
  //Future<dynamic> put(String url, {Map<String, String>? headers, dynamic body});
  Future<dynamic> delete(String url, {Map<String, String>? headers});
}

class HttpClient implements IHttpClient {
  final client = http.Client();
  Map<String, String>? _iHeader;

  Future<Map<String, String>> get iHeader async {
    if (_iHeader == null) {
      final token = await TokenStorage().getToken();
      _iHeader = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
    }
    return _iHeader!;
  }

  @override
  Future<dynamic> delete(String url, {Map<String, String>? headers}) async {
    // Implement your DELETE request logic here
    final headersToUse = headers ?? await iHeader;
    final response = await client.delete(Uri.parse(url), headers: headersToUse);

    return error_handling(response);
  }

  @override
  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    final headersToUse = headers ?? await iHeader;
    final response = await client.get(Uri.parse(url), headers: headersToUse);
    return error_handling(response);
  }

  @override
  Future<dynamic> post(String url, dynamic body) async {
    final headersToUse = Map<String, String>.from(await iHeader);
    if (url.contains("login") || url.contains("register")) {
      headersToUse.remove("Authorization");
    }
    final encodedBody = jsonEncode(body);
    final response = await client.post(
      Uri.parse(url),
      headers: headersToUse,
      body: encodedBody,
    );
    return error_handling(response);
  }
}

@override
Future<dynamic> put(
  String url, {
  Map<String, String>? headers,
  dynamic body,
}) async {
  // Implement your PUT request logic here
  return null;
}
