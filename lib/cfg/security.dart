import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String> getToken() async {
    return await _storage.read(key: 'token') ?? '';
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
  }

  Future<bool> isTokenValid() async {
    String token = await getToken();
    return token.isNotEmpty;
  }
}
