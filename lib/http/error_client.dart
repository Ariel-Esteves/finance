import 'dart:convert';

import 'package:http/http.dart';

dynamic error_handling(Response response) {
  if (response.statusCode == 200 || response.statusCode == 201) {
    try {
      print(response);
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(
        'Failed to decode response: $e\nResponse body: ${response.body}',
      );
    }
  } else {
    String errorMsg =
        'Failed to comunicate data. '
        'Status code: ${response.statusCode}, '
        'Response body: ${response.body}, ';
    throw Exception(errorMsg);
  }
}
