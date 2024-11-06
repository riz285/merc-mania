part of 'payment_cubit.dart';

enum Status {
  initial,
  inProgress,
  success,
  failure,
}

final class PaymentState extends Equatable {
  const PaymentState({
    this.creditCards,
    this.payPal,
    this.status = Status.initial,
  });

  final List<CreditCardPayment>? creditCards;
  final PayPalPayment? payPal;
  final Status status;

  @override
  List<Object?> get props => [
        creditCards,
        payPal,
        status
      ];

  PaymentState copyWith({
    PaymentMethod? paymentMethod,
    List<CreditCardPayment>? creditCards,
    PayPalPayment? payPal,
    Status? status
  }) {
    return PaymentState(
      creditCards: creditCards ?? this.creditCards,
      payPal: payPal ?? this.payPal,
      status: status ?? this.status
    );
  }
}