import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merc_mania/common/widgets/styled_add_credit_card_bottom_sheet.dart';
import 'package:merc_mania/core/configs/assets/app_format.dart';
import 'package:merc_mania/core/configs/themes/app_colors.dart';
import 'package:merc_mania/services/models/payment.dart';

import '../cubit/payment_cubit.dart';

class CardBottomSheet extends StatefulWidget {
  const CardBottomSheet({super.key});

  @override
  State<CardBottomSheet> createState() => _CardBottomSheetState();
}

class _CardBottomSheetState extends State<CardBottomSheet> {
  late List<CreditCard> creditCards;
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
      listener: (context, state) => setState(() {fetchData();}),
      child: Container(
        height: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            creditCards.isNotEmpty
            ? Expanded(
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
                StyledAddCreditCardBottomSheet()
              ],)),
          ],)
      )
    );
  }
}
