import 'package:finance/http/http_client.dart';

import 'package:finance/models/wallet_model_dto.dart';

class WalletRepository {
  final HttpClient httpClient = HttpClient();
  final String url = 'http://192.168.0.99:8080/wallet/1';

  Future<WalletModel> get() async {
    try {
      final dynamic response = await httpClient.get(url);
      print("repo unmap: $response");
      final WalletModel model = WalletModel.fromMap(response);
      print("repo from map: $model");
      return model;
    } catch (e) {
      throw Exception("requisition gets an error $e");
    }
  }

  Future<WalletModel> getById(int id) async {
    try {
      final dynamic response = await httpClient.get('$url/$id');
      return WalletModel.fromMap(response);
    } catch (e) {
      throw Exception("requisition gets an error $e");
    }
  }

  Future<WalletModel> create(WalletModel interprise) async {
    try {
      final json = interprise.toMap();
      final response = await httpClient.post(url, json);
      return WalletModel.fromMap(response);
    } catch (e) {
      throw Exception("requisition gets an error $e");
    }
  }

  Future<void> update(WalletModel interprise) async {
    try {
      final json = interprise.toMap();
      await httpClient.post(url, json);
    } catch (e) {
      throw Exception("requisition gets an error $e");
    }
  }

  Future<void> delete(int id) async {
    try {
      return await httpClient.delete('$url/$id');
    } catch (e) {
      throw Exception("requisition gets an error $e");
    }
  }
}
