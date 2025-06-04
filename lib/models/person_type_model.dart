class PersonTypeModel {
  final String name;

  PersonTypeModel({required this.name});

  factory PersonTypeModel.fromJson(Map<String, dynamic> json) {
    return PersonTypeModel(name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
