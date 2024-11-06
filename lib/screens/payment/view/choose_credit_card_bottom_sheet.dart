import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/services/models/payment.dart';

import '../cubit/payment_cubit.dart';

class ChooseCreditCardBottomSheet extends StatefulWidget {
  const ChooseCreditCardBottomSheet({super.key});

  @override
  State<ChooseCreditCardBottomSheet> createState() => _ChooseCreditCardBottomSheetState();
}

class _ChooseCreditCardBottomSheetState extends State<ChooseCreditCardBottomSheet> {
  late List<CreditCardPayment>? creditCards;
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
      child: SizedBox(
      height: MediaQuery.of(context).size.width * 0.65,
      child:  Column(
        children: [
          Expanded(
              child: ListView.separated(
                    itemCount: creditCards!.length,
                    itemBuilder: (context, index) => RadioListTile(
                        title: Text('Card Number: XXXX XXXX XXXX XXXX'),
                        subtitle:  Text('Cardholder: '),
                        value: index, 
                        selected: index == selectedIndex,
                        groupValue: selectedIndex, 
                        onChanged: (value) => setState(() {
                          selectedIndex = value ?? 0;
                        })
                      ),
                    separatorBuilder: (context, index) => SizedBox(width: 5),
              ),
            ),
          // Add new Address Button
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(children: [
              // _AddNewCreditCardButton(),
            ],)),
        ],)
      )
    );
  }
}