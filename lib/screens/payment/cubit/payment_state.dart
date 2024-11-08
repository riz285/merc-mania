part of 'payment_cubit.dart';

final class PaymentState extends Equatable {
  const PaymentState({
    required this.creditCards,
    this.fullname = const CardholderName.pure(),
    this.cardNum = const CardNumber.pure(),
    this.expiryDate = const ExpiryDate.pure(),
    this.cvv = const CVV.pure(),
    //
    this.paypal,
    this.paypalEmail = const Email.pure(),
    this.paypalPassword = const Password.pure(),
    //
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
  });

  final List<CreditCardPayment> creditCards;
  final CardholderName fullname;
  final CardNumber cardNum;
  final ExpiryDate expiryDate;
  final CVV cvv;
  //
  final PayPalPayment? paypal;
  final Email paypalEmail;
  final Password paypalPassword;
  //
  final FormzSubmissionStatus status;
  final bool isValid;

  @override
  List<Object?> get props => [
        creditCards,
        fullname,
        cardNum,
        expiryDate,
        cvv,
        //
        paypal,
        paypalEmail,
        paypalPassword,
        //
        status,
        isValid,
      ];

  PaymentState copyWith({
    List<CreditCardPayment>? creditCards,
    CardholderName? fullname,
    CardNumber? cardNum,
    ExpiryDate? expiryDate,
    CVV? cvv,
    //
    PayPalPayment? paypal,
    Email? paypalEmail,
    Password? paypalPassword,
    //
    FormzSubmissionStatus? status,
    bool? isValid,
  }) {
    return PaymentState(
      creditCards: creditCards ?? this.creditCards,
      fullname: fullname ?? this.fullname,
      cardNum: cardNum ?? this.cardNum,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      //
      paypal: paypal ?? this.paypal,
      paypalEmail: paypalEmail ?? this.paypalEmail,
      paypalPassword: paypalPassword ?? this.paypalPassword,
      //
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }
}