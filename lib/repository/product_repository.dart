import 'dart:convert';

import 'package:finance/cfg/security.dart';
import 'package:finance/http/http_client.dart';
import 'package:finance/models/product_model.dart';

class ProductRepository {
  final client = HttpClient();
  final url = 'http://192.168.0.99:8080/product';
  final tokenStorage = TokenStorage();

  Future<void> delete(int id) async {
    try {
      await client.delete('$url/$id');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<ProductModel>> getAll() async {
    try {
      final List<dynamic> data = await client.get(url);

      final List<ProductModel> products =
          data.map((item) => ProductModel.fromMap(item)).toList();

      return products;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<ProductModel> getById(int id) async {
    try {
      final response = await client.get('$url/$id');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ProductModel.fromMap(data);
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future insert(ProductModel model) async {
    // TODO: implement insert

    final data = model.toMap();
    final response = await client.post(url, data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Product inserted successfully');
      return ProductModel.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to insert product');
    }
  }
}
