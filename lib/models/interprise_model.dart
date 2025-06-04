import './adress_model.dart';

class InterpriseModel {
  final int? id;
  final String name;
  final String cpf;
  final String cep;
  final AddressModel? address;

  InterpriseModel({
    this.id,
    required this.name,
    required this.cpf,
    required this.cep,
    required this.address,
  });

  factory InterpriseModel.fromJson(Map<String, dynamic> json) {
    return InterpriseModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      cpf: json['cpf'] as String,
      cep: (json['address']?['cep'] ?? '') as String,
      address:
          json['address'] != null
              ? AddressModel.fromMap(json['address'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cpf': cpf,
      'address': {'cep': cep},
    };
  }
}
