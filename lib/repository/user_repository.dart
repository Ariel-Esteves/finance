import 'package:finance/cfg/security.dart';
import 'package:finance/models/user_model.dart';
import 'package:finance/http/http_client.dart';
import 'package:finance/repository/person_repository.dart';

class UserRepository {
  final String url = 'http://192.168.0.99:8080/auth/';
  final _httpClient = HttpClient();
  final _tokenStorage = TokenStorage();
  final personRepository = PersonRepository();

  Future<void> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<List> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  Future getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  Future insert(UserModel model) async {
    try {
      _tokenStorage.deleteToken();
      final response = await _httpClient.post('${url}register', model.toMap());
      _tokenStorage.saveToken(response['token']);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('User registered successfully');
      } else {
        throw Exception('Failed to register user. Body was: ${model.toMap()}');
      }
      return UserModel.fromMap(response);
    } catch (e) {
      // Handle error
      throw Exception('Failed to register user: $e');
    }
  }

  Future login(UserModel model) async {
    _tokenStorage.deleteToken();
    final response = await _httpClient.post('${url}login', model.toMap());
    _tokenStorage.saveToken(response['token'] ?? '');
    return response;
  }
}
