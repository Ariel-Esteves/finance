import 'dart:convert';

import 'package:finance/cfg/security.dart';
import 'package:finance/http/http_client.dart';
import 'package:finance/models/person_model.dart';
import 'package:finance/models/person_type_model.dart';

abstract class IPersonRepository {
  Future<List> getAll();

  Future getById(int id);

  Future insert(PersonModel person);

  Future<void> delete(int id);
}

class PersonRepository implements IPersonRepository {
  final client = HttpClient();
  final url = 'http://192.168.0.99:8080/person';
  final tokenStorage = TokenStorage();

  @override
  Future<void> delete(int id) async {
    try {
      await client.delete('$url/$id');
    } catch (e) {
      throw Exception('requisition gets an error $e');
    }
  }

  @override
  Future<List<PersonModel>> getAll() async {
    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<PersonModel> products =
            data.map((item) => PersonModel.fromMap(item)).toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('requisition gets an error $e');
    }
  }

  @override
  Future<PersonModel> getById(int id) async {
    try {
      final response = await client.get('$url/$id');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PersonModel.fromMap(data);
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('requisition gets an error $e');
    }
  }

  @override
  Future<PersonModel> findByName(String name) async {
    try {
      final response = await client.get('$url/$name');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PersonModel.fromMap(data);
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('requisition gets an error $e');
    }
  }

  @override
  Future insert(PersonModel model) async {
    try {
      final modelMapped = model.toMap();
      final response = await client.post(url, modelMapped);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Person inserted successfully');
        return PersonModel.fromMap(response);
      } else {
        throw Exception('Failed to insert person');
      }
    } catch (e) {
      throw Exception('requisition gets an error $e');
    }
  }

  Future insertType(PersonTypeModel model) async {
    try {
      final modelMapped = model.toJson();
      final data = jsonEncode(modelMapped);
      final response = await client.post('$url/entidadetipo', data);
      if (response.statusCode == 200) {
        return PersonTypeModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to insert product');
      }
    } catch (e) {
      throw Exception('requisition gets an error $e');
    }
  }
}
