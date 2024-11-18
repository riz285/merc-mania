import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merc_mania/common/widgets/styled_add_credit_card_bottom_sheet.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import '../../../core/configs/assets/app_format.dart';
import '../cubit/payment_cubit.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({super.key});

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  
  @override
  Widget build(BuildContext context) {
    final creditCards = context.read<PaymentCubit>().state.creditCards;
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) => setState(() {}),
      child: Scaffold(
        appBar: StyledAppBar(title: Text('Credit Cards')),
        body: Column(
          children: [
            creditCards.isNotEmpty ?
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(8),
                itemCount: creditCards.length,
                itemBuilder: (context, index) => ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  leading: Icon(FontAwesomeIcons.creditCard),
                  title: Text(AppFormat.cardnumber.format(int.parse(creditCards[index].cardNumber)).replaceAll(',', ' '), style: TextStyle(fontSize: 20)),
                  subtitle:  Text(creditCards[index].cardHolderName, style: TextStyle(fontSize: 12)),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<PaymentCubit>().removeCard(creditCards[index]);
                    }, 
                    icon: Icon(FontAwesomeIcons.trashCan)),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 5),
                ),
            )
            : Align(
              child: Text('There is no credit card')),
            // Add new Credit Card Button
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: StyledAddCreditCardBottomSheet()
            ),
          ],
        ),
      )
    );
  }
}