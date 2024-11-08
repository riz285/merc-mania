import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merc_mania/core/configs/assets/app_format.dart';
import 'package:merc_mania/core/configs/themes/app_colors.dart';
import 'package:merc_mania/services/models/payment.dart';

import '../../../core/configs/assets/card_number_formatter.dart';
import '../cubit/payment_cubit.dart';

class ChooseCreditCardBottomSheet extends StatefulWidget {
  const ChooseCreditCardBottomSheet({super.key});

  @override
  State<ChooseCreditCardBottomSheet> createState() => _ChooseCreditCardBottomSheetState();
}

class _ChooseCreditCardBottomSheetState extends State<ChooseCreditCardBottomSheet> {
  late List<CreditCardPayment> creditCards;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    creditCards = context.read<PaymentCubit>().state.creditCards;
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) => setState(() {}),
      child: Container(
        height: MediaQuery.of(context).size.width * 0.65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            creditCards.isNotEmpty ?
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(8),
                itemCount: creditCards.length,
                itemBuilder: (context, index) => ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  leading: Icon(FontAwesomeIcons.creditCard, color: AppColors.primary),
                  title: Text(AppFormat.cardnumber.format(int.parse(creditCards[index].cardNumber)).replaceAll(',', ' '), style: TextStyle(fontSize: 20, color: AppColors.primary)),
                  subtitle:  Text(creditCards[index].cardHolderName, style: TextStyle(fontSize: 12, color: AppColors.primary)),
                  selected: index == selectedIndex,
                  onTap: () => setState(() {
                    selectedIndex = index;
                  })
                ),
                separatorBuilder: (context, index) => SizedBox(width: 5),
                ),
              ) 
            : Align(
              child: Text('There is no credit card')),
            // Add new Credit Card Button
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                _AddNewCreditCardButton(),
              ],)),
          ],)
      )
    );
  }
}

class _AddNewCreditCardButton extends StatelessWidget {
  const _AddNewCreditCardButton();

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
      }, 
      child: Text('LINK CARD'));
  }
}