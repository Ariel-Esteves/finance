class PersonModel {
  int _id;
  String _name;

  String _cpf;

  String _userType;

  String _user;

  PersonModel(this._id, this._name, this._cpf, this._userType, this._user);

  int get id => _id;
  String get name => _name;
  String get cpf => _cpf;
  String get user => _user;

  String get personType => _userType;

  set id(int id) {
    _id = id;
  }

  set name(String name) {
    _name = name;
  }

  set cpf(String cpf) {
    _cpf = cpf;
  }

  set person(String person) {
    _user = user;
  }

  factory PersonModel.fromMap(Map<String, dynamic> json) {
    return PersonModel(
      json['id'] as int,
      json['name'] as String,
      json['cpf'] as String,
      json['user'] as String,
      json['personType'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'cpf': _cpf,
      'personType': _userType,
      'user': _user,
    };
  }
}
