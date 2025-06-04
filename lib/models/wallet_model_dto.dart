class Movement {
  final int id;
  final double paymentValue;
  final DateTime dateTime;
  final int sale;
  final String movementType;

  Movement({
    required this.id,
    required this.paymentValue,
    required this.dateTime,
    required this.sale,
    required this.movementType,
  });

  factory Movement.fromMap(Map<String, dynamic> map) {
    return Movement(
      id: map['id'] as int,
      paymentValue: (map['paymentValue'] as num).toDouble(),
      dateTime: DateTime.parse(map['dateTime'] as String),
      sale: map['sale'] as int,
      movementType: map['movementType'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'paymentValue': paymentValue,
      'dateTime': dateTime.toIso8601String(),
      'movementType': movementType,
    };
  }
}

class WalletModel {
  final int id;
  final double balance;
  final double income;
  final double outcome;
  final DateTime dateTime;
  final int person;
  final List<Movement> movement;

  WalletModel({
    required this.id,
    required this.balance,
    required this.income,
    required this.outcome,
    required this.dateTime,
    required this.person,
    required this.movement,
  });

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      id: map['id'] as int,
      balance: (map['balance'] as num).toDouble(),
      income: (map['income'] as num).toDouble(),
      outcome: (map['outcome'] as num).toDouble(),
      dateTime: DateTime.parse(map['dateTime'] as String),
      person: map['person'] as int,
      movement:
          (map['movement'] as List<dynamic>)
              .map((e) => Movement.fromMap(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'balance': balance,
      'income': income,
      'outcome': outcome,
      'dateTime': dateTime.toIso8601String(),
      'person': person,
      'movement': movement.map((e) => e.toMap()).toList(),
    };
  }
}
