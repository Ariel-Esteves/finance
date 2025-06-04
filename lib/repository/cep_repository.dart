import 'dart:convert';

import 'package:finance/http/http_client.dart';
import 'package:finance/models/adress_model.dart';

class CepRepository {
  final HttpClient _httpClient = HttpClient();
  final String _url = 'http://192.168.0.99:8080/cep/';

  Future<AddressModel> getByCep(String cep) async {
    print('$_url$cep');
    final response = await _httpClient.get(
      '$_url$cep',
      headers: {'Content-Type': 'application/json'},
    );

    print(response);
    return AddressModel.fromMap(response);
  }
}
