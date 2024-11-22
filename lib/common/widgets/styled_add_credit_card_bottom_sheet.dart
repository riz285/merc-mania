import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../screens/payment/card_number_formatter.dart';
import '../../core/configs/themes/app_colors.dart';
import '../../screens/payment/cubit/payment_cubit.dart';

class StyledAddCreditCardBottomSheet extends StatelessWidget {
  const StyledAddCreditCardBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        showModalBottomSheet(context: context, isScrollControlled: true, builder: (BuildContext context) => SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Link a card'),
                SizedBox(height: 20),
                _CardNumberInput(),
                SizedBox(height: 20),
                _CardholderNameInput(),
                Row(
                  children: [
                    Expanded(child: _ExpiryDateInput()),
                    SizedBox(width: 5),
                    Expanded(child: _CVVInput()),
                ]),
                SizedBox(height: 20),
                _LinkButton()
              ]),
          )
        ));
      }, 
      child: const Text('Add credit card'));
  }
}

class _CardNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (PaymentCubit cubit) => cubit.state.cardNum.displayError,
    );

    return TextField(
      key: const Key('addCardForm_cardNumInput_textField'),
      onChanged: (number) => context.read<PaymentCubit>().cardNumberChanged(number),
      keyboardType: TextInputType.number,
      inputFormatters: [
        CardNumberFormatter()],
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
          color: AppColors.primary)),
        prefixIcon: Icon(FontAwesomeIcons.creditCard),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
          color: AppColors.primary,
          width: 3)
        ),
        labelText: 'card number',
        labelStyle: TextStyle(color: AppColors.primary),
        hintText: 'XXXX XXXX XXXX XXXX',
        errorText: displayError != null ? 'invalid number' : null,
      ),
    );
  }
}

class _CardholderNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (PaymentCubit cubit) => cubit.state.fullname.displayError,
    );

    return TextField(
      key: const Key('addCardForm_nameInput_textField'),
      onChanged: (name) => context.read<PaymentCubit>().cardholderNameChanged(name),
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
          color: AppColors.primary)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
          color: AppColors.primary,
          width: 3)
        ),
        labelText: 'cardholder name',
        labelStyle: TextStyle(color: AppColors.primary),
        helperText: '',
        errorText: displayError != null ? 'invalid name' : null,
      ),
    );
  }
}

class _ExpiryDateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (PaymentCubit cubit) => cubit.state.expiryDate.displayError,
    );

    return TextField(
      key: const Key('addCardForm_expiryDateInput_textField'),
      onChanged: (date) => context.read<PaymentCubit>().expiryDateChanged(date),
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
          color: AppColors.primary)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
          color: AppColors.primary,
          width: 3)
        ),
        labelText: 'expiry date',
        labelStyle: TextStyle(color: AppColors.primary),
        hintText: 'mm/yy',
        errorText: displayError != null ? 'invalid date' : null,
      ),
    );
  }
}

class _CVVInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (PaymentCubit cubit) => cubit.state.cvv.displayError,
    );

    return TextField(
      key: const Key('addCardForm_cvvInput_textField'),
      onChanged: (number) => context.read<PaymentCubit>().cvvChanged(number),
      obscureText: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
          color: AppColors.primary)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
          color: AppColors.primary,
          width: 3)
        ),
        labelText: 'cvv',
        labelStyle: TextStyle(color: AppColors.primary),
        errorText: displayError != null ? 'invalid cvv' : null,
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  const _LinkButton();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PaymentCubit>(context);
    return TextButton(
      onPressed: () {
        cubit.addCardSubmitted();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('A new card is added!'),
              ),
            );
      }, 
      child: Text('LINK CARD'));
  }
}