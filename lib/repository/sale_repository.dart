import 'dart:convert';

import 'package:finance/http/http_client.dart';
import 'package:finance/models/sale_dto_model.dart';
import 'package:finance/models/sale_model.dart';

class SaleRepository {
  final String _baseUrl = 'http://192.168.0.99:8080/sale';
  final httpClient = HttpClient();

  Future<List<SaleModelDto>> getAll() async {
    try {
      final List<dynamic> sales = await httpClient.get(_baseUrl);
      final List<SaleModelDto> salesMapped =
          sales.map((toElement) {
            // Format dateValue if it exists
            if (toElement['dateValue'] != null) {
              final date = DateTime.tryParse(toElement['dateValue']);
              if (date != null) {
                // Format as ddMMyy
                final formatted =
                    '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().substring(2)}';
                toElement['dateValue'] = formatted;
              }
            }
            return SaleModelDto.fromMap(toElement);
          }).toList();
      return salesMapped;
    } catch (e) {
      throw Exception("requisition gets an error $e");
    }
  }

  Future<void> createSale(SaleModelDto sale) async {
    try {
      final json = sale.toMap();
      final response = await httpClient.post(_baseUrl, json);
      return response;
    } catch (e) {
      throw Exception("requisition gets an error $e");
    }
  }

  Future<void> updateSale(SaleModelDto sale) async {
    try {
      // Logic to update an existing sale record
    } catch (e) {
      throw Exception("requisition gets an error $e");
    }
  }

  Future<void> deleteSale(String saleId) async {
    try {
      // Logic to delete a sale record by its ID
    } catch (e) {
      throw Exception("requisition gets an error $e");
    }
  }

  Future<SaleModel> findById(String id) async {
    try {
      print('Fetching sale with ID: $id');
      final json = await httpClient.get('$_baseUrl/$id');
      print(json);
      return SaleModel.fromMap(json);
    } catch (e) {
      throw Exception("requisition gets an error $e");
    }
  }

  Future<List<dynamic>> getStatistics() async {
    try {
      final List<dynamic> sales = await httpClient.get('$_baseUrl/statitics');
      return sales;
    } catch (e) {
      throw Exception("requisition gets an error $e");
    }
  }
}
