// ignore_for_file: empty_constructor_bodies

abstract class PaymentMethod {
  PaymentMethod({
    required this.id,
    required this.title,
    required this.icon
  });

  final String id;
  final String title;
  final String icon;

  Future<bool> processPayment(int amount);
}

// Credit Card Payment Method
class CreditCardPayment extends PaymentMethod {
  final String cardNumber;
  final String expiryDate;
  final String cvv;

  CreditCardPayment({
    required super.id,
    required super.title,
    required super.icon,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv
  });

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
    required super.id,
    required super.title,
    required super.icon,
    required this.email,
    required this.password
  });


  @override
  Future<bool> processPayment(int amount) {
    // TODO: implement PayPal payment
    throw UnimplementedError();
  }
}