import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:merc_mania/services/models/payment.dart';

part 'payment_state.dart';

class PaymentCubit extends HydratedCubit<PaymentState> {
  PaymentCubit() : super(const PaymentState());
  
  List<CreditCardPayment> creditCardsFromJson(List<dynamic> json) {
    return json.map((e) => CreditCardPayment.fromJson(e)).toList();
  }

  List<dynamic> creditCardsToJson(List<CreditCardPayment> creditCards) {
    return creditCards.map((e) => e.toJson()).toList();
  }

  @override
  PaymentState? fromJson(Map<String, dynamic> json) {
    return PaymentState(
      creditCards: creditCardsFromJson(json['credit_cards']), 
      payPal: json['paypal'], 
    );
  }
  
  @override
  Map<String, dynamic>? toJson(PaymentState state) {
    return {
      'credit_cards' : creditCardsToJson(state.creditCards!),
      'paypal' : state.payPal,
    };
  }

  
}