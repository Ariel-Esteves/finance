class MovementSaleModelDto {
  int id;
  int product;
  double paymentValue;
  double quantity;

  int get getId => id;
  int get getProduct => product;
  double get getPaymentValue => paymentValue;
  double get getQuantity => quantity;
  set setId(int id) {
    id = id;
  }

  set setProduct(int product) {
    product = product;
  }

  set setPaymentValue(double paymentValue) {
    paymentValue = paymentValue;
  }

  set setQuantity(double quantity) {
    quantity = quantity;
  }

  MovementSaleModelDto(this.id, this.product, this.paymentValue, this.quantity);
}

class SaleModelDto {
  int id;
  double paymentValue;
  int saleType;
  int person;
  List<MovementSaleModelDto> movementSale;
  String dateValue;

  SaleModelDto(
    this.id,
    this.paymentValue,
    this.saleType,
    this.person,
    this.movementSale,
    this.dateValue,
  );

  // Removed redundant getters and setters to avoid naming conflicts.

  void addMovementSale(MovementSaleModelDto movement) {
    movementSale.add(movement);
  }

  void removeMovementSale(MovementSaleModelDto movement) {
    movementSale.remove(movement);
  }

  void clearMovementSale() {
    movementSale.clear();
  }

  void addPaymentValue(double paymentValue) {
    paymentValue += paymentValue;
  }

  void removePaymentValue(double paymentValue) {
    paymentValue -= paymentValue;
  }

  void clearPaymentValue() {
    paymentValue = 0.0;
  }

  void addSaleType(int saleType) {
    saleType += saleType;
  }

  void removeSaleType(int saleType) {
    saleType -= saleType;
  }

  void clearSaleType() {
    saleType = 0;
  }

  void addPerson(int person) {
    person = person;
  }

  factory SaleModelDto.fromMap(Map<String, dynamic> json) {
    return SaleModelDto(
      json['id'] as int,
      json['paymentValue'] as double,
      json['saleType'] as int,
      json['person'] as int,
      (json['movementSale'] as List)
          .map(
            (e) => MovementSaleModelDto(
              e['id'] as int,
              e['product'] as int,
              e['paymentValue'] as double,
              e['quantity'] as double,
            ),
          )
          .toList(),
      json['dateValue'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'paymentValue': paymentValue,
      'saleType': saleType,
      'person': person,
      'movementSale':
          movementSale
              .map(
                (movement) => {
                  'id': movement.getId,
                  'product': movement.getProduct,
                  'paymentValue': movement.getPaymentValue,
                  'quantity': movement.getQuantity,
                },
              )
              .toList(),
      'dateValue': dateValue,
    };
  }
}
