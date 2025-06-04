import 'dart:convert';

import 'package:finance/http/http_client.dart';
import 'package:finance/models/interprise_model.dart';

class InterpriseRepository {
  final HttpClient httpClient = HttpClient();
  final String url = 'http://192.168.0.99:8080/person';

  Future<List<InterpriseModel>> getAll() async {
    try {
      final List<dynamic> response = await httpClient.get(url);
      print(response);
      final List<InterpriseModel> model =
          response.map((item) => InterpriseModel.fromJson(item)).toList();
      return model;
    } catch (e) {
      throw Exception("requisition returned an error $e");
    }
  }

  Future<InterpriseModel> getById(int id) async {
    try {
      return await httpClient.get('$url/$id');
    } catch (e) {
      throw Exception("requisition returned an error $e");
    }
  }

  Future<InterpriseModel> create(InterpriseModel interprise) async {
    try {
      final json = interprise.toJson();
      final response = await httpClient.post(url, json);
      return InterpriseModel.fromJson(response);
    } catch (e) {
      throw Exception("requisition returned an error $e");
    }
  }

  Future<void> update(InterpriseModel interprise) async {
    try {
      return await httpClient.post(url, interprise);
    } catch (e) {
      throw Exception("requisition returned an error $e");
    }
  }

  Future<void> delete(int id) async {
    try {
      return await httpClient.delete('$url/$id');
    } catch (e) {
      throw Exception("requisition returned an error $e");
    }
  }
}
