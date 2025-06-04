class UserModel {
  final String login;
  final String password;
  String? token;

  /*  final String name;
  final String cpf;
  final String cep;
  final AddressModel? address;

  InterpriseModel({
    required this.name,
    required this.cpf,
    required this.cep,
    required this.address,
  });*/
  UserModel({required this.login, required this.password, this.token});

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      login: json['login'] as String,
      password: json['password'] as String,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {'login': login, 'password': password, 'token': token};
  }
}
