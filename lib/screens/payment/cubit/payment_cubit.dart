// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:merc_mania/services/models/payment.dart';

part 'payment_state.dart';

class PaymentCubit extends HydratedCubit<PaymentState> {
  PaymentCubit() : super(const PaymentState(creditCards: []));
  
  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        paypalEmail: email,
        isValid: Formz.validate([email, state.paypalPassword]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        paypalPassword: password,
        isValid: Formz.validate([state.paypalEmail, password]),
      ),
    );
  }

  void cardNumberChanged(String value) {
    final cardNumber = CardNumber.dirty(value.replaceAll(' ', ''));
    emit(
      state.copyWith(
        cardNum: cardNumber,
        isValid: Formz.validate([cardNumber, state.fullname, state.expiryDate, state.cvv]),
      ),
    );
  }

  void cardholderNameChanged(String value) {
    final name = CardholderName.dirty(value);
    emit(
      state.copyWith(
        fullname: name,
        isValid: Formz.validate([state.cardNum, name, state.expiryDate, state.cvv]),
      ),
    );
  }

  void expiryDateChanged(String value) {
    final date = ExpiryDate.dirty(value);
    emit(
      state.copyWith(
        expiryDate: date,
        isValid: Formz.validate([state.cardNum, state.fullname, date, state.cvv]),
      ),
    );
  }

  void cvvChanged(String value) {
    final cvv = CVV.dirty(value);
    emit(
      state.copyWith(
        cvv: cvv,
        isValid: Formz.validate([state.cardNum, state.fullname, state.expiryDate, cvv]),
      ),
    );
  }

  /// Add Card to Cache 
  void addCard() {
    final CreditCard creditCard = CreditCard(
      cardNumber: state.cardNum.value, 
      cardHolderName: state.fullname.value, 
      expiryDate: state.expiryDate.value, 
      cvv: state.cvv.value
      );
    final updatedList = state.creditCards.toList();
    if (updatedList.isNotEmpty) updatedList.remove(creditCard);
    updatedList.insert(0, creditCard); // add to headList
    emit(
      state.copyWith(
         creditCards: updatedList.toList(),
      )
    );
  }

  /// Remove Card from Cache
  void removeCard(CreditCard creditCard) {
    final updatedList = state.creditCards.toList();
    updatedList.remove(creditCard); // 
    emit(
      state.copyWith(
         creditCards: updatedList.toList(),
      )
    );
  }

  List<CreditCard> creditCardsFromJson(List<dynamic> json) {
    return json.map((e) => CreditCard.fromJson(e)).toList();
  }

  List<dynamic> creditCardsToJson(List<CreditCard> creditCards) {
    return creditCards.map((e) => e.toJson()).toList();
  }

  @override
  PaymentState? fromJson(Map<String, dynamic> json) {
    return PaymentState(
      creditCards: creditCardsFromJson(json['credit_cards']), 
      paypal: json['paypal'], 
    );
  }
  
  @override
  Map<String, dynamic>? toJson(PaymentState state) {
    return {
      'credit_cards' : creditCardsToJson(state.creditCards),
      'paypal' : state.paypal,
    };
  }

  Future<void> addCardSubmitted() async {
    if (!state.isValid) return;
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      addCard();
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}