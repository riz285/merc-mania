abstract class PaymentMethod {
  Future<bool> processPayment(int amount);
}

// COD Payment Method
class CashPayment extends PaymentMethod {

  @override
  Future<bool> processPayment(int amount) async {
    // TODO: implement Credit Card Payment
    throw UnimplementedError();
  }
}

// Credit Card Payment Method
class CreditCard extends PaymentMethod {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;

  CreditCard({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv
  });

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      cardNumber: json['card_number'],
      cardHolderName: json['cardholder_name'],
      expiryDate: json['expiry_date'],
      cvv: json['cvv']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'card_number' : cardNumber,
      'cardholder_name' : cardHolderName,
      'expiry_date' : expiryDate,
      'cvv' : cvv
    };
  }

  @override
  Future<bool> processPayment(int amount) async {
    // TODO: implement Credit Card Payment
    throw UnimplementedError();
  }
}

// PayPal Payment Method
class PayPalPayment extends PaymentMethod {
  final String email;
  final String password;

  PayPalPayment({
    required this.email,
    required this.password
  });

  factory PayPalPayment.fromJson(Map<String, dynamic> json) {
    return PayPalPayment(
      email: json['email'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email' : email,
      'password' :password
    };
  }

  @override
  Future<bool> processPayment(int amount) {
    // TODO: implement PayPal payment
    throw UnimplementedError();
  }
}