class ProductModel {
  final int? id;
  final String name;
  final String description; // Make description nullable
  final double price;
  final double stock;

  ProductModel({
    this.id,
    required this.name,
    this.description = '', // Nullable field with default value
    required this.price,
    this.stock = 0.0, // Nullable field with default value
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] != null ? json['id'] as int : 0, // Handle nullability
      name: json['name'] as String,
      description:
          json['description'] == null
              ? ''
              : json['description'] as String, // Handle nullability
      price:
          json['price'] is double
              ? json['price'] as double
              : double.tryParse(json['price'].toString()) ?? 0.0,
      stock:
          json['stock'] == null
              ? 0.0
              : (json['stock']['quantity'] as num)
                  .toDouble(), // Handle nullability
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? 0, // Handle nullability
      'name': name,
      'description': description, // Nullable field
      'price': price,
      'stock': stock, // Nullable field
    };
  }
}
