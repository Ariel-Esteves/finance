class SaleModel {
  final int id;
  final double paymentValue;
  final DateTime data;
  final SaleType saleType;
  final Person person;
  final List<MovementSale> movementSales;
  final String dateValue;

  SaleModel({
    required this.id,
    required this.paymentValue,
    required this.data,
    required this.saleType,
    required this.person,
    required this.movementSales,
    required this.dateValue,
  });

  factory SaleModel.fromMap(Map<String, dynamic> map) {
    try {
      return SaleModel(
        id: map['id'],
        paymentValue: map['paymentValue'],
        data: DateTime.parse(map['data']),
        saleType: SaleType.fromMap(map['saleType']),
        person: Person.fromMap(map['person']),
        movementSales:
            map['movementSales'] != null && map['movementSales'].length != 0
                ? (map['movementSales'] as List)
                    .map((e) => MovementSale.fromMap(e))
                    .toList()
                : [],
        dateValue: DateTime.parse(map['data']).toIso8601String(),
      );
    } catch (e) {
      throw Exception('Error parsing SaleModel: $e');
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return {
        'id': id,
        'paymentValue': paymentValue,
        'data': data.toIso8601String(),
        'saleType': saleType.toMap(),
        'person': person.toMap(),
        'movementSales': movementSales.map((e) => e.toMap()).toList(),
      };
    } catch (e) {
      throw Exception('Error serializing SaleModel: $e');
    }
  }
}

class SaleType {
  final int id;
  final String name;
  final List<dynamic> sale;

  SaleType({required this.id, required this.name, required this.sale});
  factory SaleType.fromMap(Map<String, dynamic> map) {
    try {
      return SaleType(
        id: map['id'],
        name: map['name'],
        sale: map['sale'] ?? [],
      );
    } catch (e) {
      throw Exception('Error parsing SaleType: $e');
    }
  }
  Map<String, dynamic> toMap() {
    try {
      return {'id': id, 'name': name, 'sale': sale};
    } catch (e) {
      throw Exception('Error serializing SaleType: $e');
    }
  }
}

class Person {
  int? id;
  String? name;

  Person({this.id, this.name});
  factory Person.fromMap(Map<String, dynamic> map) {
    try {
      return Person(id: map['id'], name: map['name']);
    } catch (e) {
      throw Exception('Error parsing Person: $e');
    }
  }
  Map<String, dynamic> toMap() {
    try {
      return {'id': id, 'name': name};
    } catch (e) {
      throw Exception('Error serializing Person: $e');
    }
  }
}

class Address {
  final int? id;
  final String? street;
  final String? city;
  final String? cep;
  final String? country;
  final String? neighborhood;
  final String? state;
  final int? number;

  Address({
    this.id,
    this.street,
    this.city,
    this.cep,
    this.country,
    this.neighborhood,
    this.state,
    this.number,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    try {
      return Address(
        id: map['id'],
        street: map['street'],
        city: map['city'],
        cep: map['cep'],
        country: map['country'],
        neighborhood: map['neighborhood'],
        state: map['state'],
        number: map['number'],
      );
    } catch (e) {
      throw Exception('Error parsing Address: $e');
    }
  }
  Map<String, dynamic> toMap() {
    try {
      return {
        'id': id,
        'street': street,
        'city': city,
        'cep': cep,
        'country': country,
        'neighborhood': neighborhood,
        'state': state,
        'number': number,
      };
    } catch (e) {
      throw Exception('Error serializing Address: $e');
    }
  }
}

class PersonType {
  final int id;
  final String name;
  final DateTime creation;
  final List<dynamic> person;

  PersonType({
    required this.id,
    required this.name,
    required this.creation,
    required this.person,
  });

  factory PersonType.fromMap(Map<String, dynamic> map) {
    try {
      return PersonType(
        id: map['id'],
        name: map['name'],
        creation: DateTime.parse(map['creation']),
        person: map['person'] ?? [],
      );
    } catch (e) {
      throw Exception('Error parsing PersonType: $e');
    }
  }
  Map<String, dynamic> toMap() {
    try {
      return {
        'id': id,
        'name': name,
        'creation': creation.toIso8601String(),
        'person': person,
      };
    } catch (e) {
      throw Exception('Error serializing PersonType: $e');
    }
  }
}

class Movement {
  final int id;
  final double paymentValue;
  final DateTime data;
  final String movementType;

  Movement({
    required this.id,
    required this.paymentValue,
    required this.data,
    required this.movementType,
  });

  factory Movement.fromMap(Map<String, dynamic> map) {
    try {
      return Movement(
        id: map['id'],
        paymentValue: map['paymentValue'],
        data: DateTime.parse(map['data']),
        movementType: map['movementType'],
      );
    } catch (e) {
      throw Exception('Error parsing Movement: $e');
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return {
        'id': id,
        'paymentValue': paymentValue,
        'data': data.toIso8601String(),
        'movementType': movementType,
      };
    } catch (e) {
      throw Exception('Error serializing Movement: $e');
    }
  }
}

class UserEntity {
  final int id;
  final String login;
  final String password;
  final String role;
  final String? token;
  final String? refreshToken;
  final String? status;
  final dynamic person;
  final bool enabled;
  final String? username;
  final List<Authority> authorities;
  final bool credentialsNonExpired;
  final bool accountNonExpired;
  final bool accountNonLocked;

  UserEntity({
    required this.id,
    required this.login,
    required this.password,
    required this.role,
    this.token,
    this.refreshToken,
    this.status,
    this.person,
    required this.enabled,
    this.username,
    required this.authorities,
    required this.credentialsNonExpired,
    required this.accountNonExpired,
    required this.accountNonLocked,
  });

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    try {
      return UserEntity(
        id: map['id'],
        login: map['login'],
        password: map['password'],
        role: map['role'],
        token: map['token'],
        refreshToken: map['refreshToken'],
        status: map['status'],
        person: map['person'],
        enabled: map['enabled'],
        username: map['username'],
        authorities:
            map['authorities'] != null
                ? (map['authorities'] as List)
                    .map((e) => Authority.fromMap(e))
                    .toList()
                : [],
        credentialsNonExpired: map['credentialsNonExpired'],
        accountNonExpired: map['accountNonExpired'],
        accountNonLocked: map['accountNonLocked'],
      );
    } catch (e) {
      throw Exception('Error parsing UserEntity: $e');
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return {
        'id': id,
        'login': login,
        'password': password,
        'role': role,
        'token': token,
        'refreshToken': refreshToken,
        'status': status,
        'person': person,
        'enabled': enabled,
        'username': username,
        'authorities': authorities.map((e) => e.toMap()).toList(),
        'credentialsNonExpired': credentialsNonExpired,
        'accountNonExpired': accountNonExpired,
        'accountNonLocked': accountNonLocked,
      };
    } catch (e) {
      throw Exception('Error serializing UserEntity: $e');
    }
  }
}

class Authority {
  final String authority;

  Authority({required this.authority});

  factory Authority.fromMap(Map<String, dynamic> map) {
    try {
      return Authority(authority: map['authority']);
    } catch (e) {
      throw Exception('Error parsing Authority: $e');
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return {'authority': authority};
    } catch (e) {
      throw Exception('Error serializing Authority: $e');
    }
  }
}

class MovementSale {
  final int id;
  final double quantity;
  final double paymentValue;
  final Product product;

  MovementSale({
    required this.id,
    required this.quantity,
    required this.paymentValue,
    required this.product,
  });

  factory MovementSale.fromMap(Map<String, dynamic> map) {
    try {
      return MovementSale(
        id: map['id'],
        quantity: map['quantity'],
        paymentValue: map['paymentValue'],
        product: Product.fromMap(map['product']),
      );
    } catch (e) {
      throw Exception('Error parsing MovementSale: $e');
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return {
        'id': id,
        'quantity': quantity,
        'paymentValue': paymentValue,
        'product': product.toMap(),
      };
    } catch (e) {
      throw Exception('Error serializing MovementSale: $e');
    }
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final double? cost;
  final Stock stock;
  final List<dynamic> movementSaleEntity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.cost,
    required this.stock,
    required this.movementSaleEntity,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    try {
      return Product(
        id: map['id'],
        name: map['name'],
        price: map['price'],
        cost: map['cost'],
        stock: Stock.fromMap(map['stock']),
        movementSaleEntity: map['movementSaleEntity'] ?? [],
      );
    } catch (e) {
      throw Exception('Error parsing Product: $e');
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return {
        'id': id,
        'name': name,
        'price': price,
        'cost': cost,
        'stock': stock.toMap(),
        'movementSaleEntity': movementSaleEntity,
      };
    } catch (e) {
      throw Exception('Error serializing Product: $e');
    }
  }
}

class Stock {
  final int id;
  final double quantity;
  final DateTime data;
  final List<MovementStockEntity> movementStockEntity;

  Stock({
    required this.id,
    required this.quantity,
    required this.data,
    required this.movementStockEntity,
  });

  factory Stock.fromMap(Map<String, dynamic> map) {
    try {
      return Stock(
        id: map['id'],
        quantity: map['quantity'],
        data: DateTime.parse(map['data']),
        movementStockEntity:
            map['movementStockEntity'] != null
                ? (map['movementStockEntity'] as List)
                    .map((e) => MovementStockEntity.fromMap(e))
                    .toList()
                : [],
      );
    } catch (e) {
      throw Exception('Error parsing Stock: $e');
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return {
        'id': id,
        'quantity': quantity,
        'data': data.toIso8601String(),
        'movementStockEntity':
            movementStockEntity.map((e) => e.toMap()).toList(),
      };
    } catch (e) {
      throw Exception('Error serializing Stock: $e');
    }
  }
}

class MovementStockEntity {
  final int id;
  final double quantity;
  final String movementType;

  MovementStockEntity({
    required this.id,
    required this.quantity,
    required this.movementType,
  });

  factory MovementStockEntity.fromMap(Map<String, dynamic> map) {
    try {
      return MovementStockEntity(
        id: map['id'],
        quantity: map['quantity'],
        movementType: map['movementType'],
      );
    } catch (e) {
      throw Exception('Error parsing MovementStockEntity: $e');
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return {'id': id, 'quantity': quantity, 'movementType': movementType};
    } catch (e) {
      throw Exception('Error serializing MovementStockEntity: $e');
    }
  }
}
