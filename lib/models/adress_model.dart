class AddressModel {
  int id;

  String uf;

  String street;

  String city;

  String cep;

  String country;

  int number;

  String neighborhood;

  AddressModel({
    required this.id,
    required this.uf,
    required this.street,
    required this.city,
    required this.cep,
    required this.country,
    required this.number,
    required this.neighborhood,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uf': uf,
      'street': street,
      'city': city,
      'cep': cep,
      'country': country,
      'number': number,
      'neighborhood': neighborhood,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] ?? 0,
      uf: map['state'] ?? '',
      street: map['street'] ?? '',
      city: map['city'] ?? '',
      cep: map['cep'] ?? '',
      country: map['country'] ?? '',
      number: map['number'] ?? 0,
      neighborhood: map['neighborhood'] ?? '',
    );
  }
}
