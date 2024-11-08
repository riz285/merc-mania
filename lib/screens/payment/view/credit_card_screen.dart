import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import '../../../core/configs/assets/app_format.dart';
import '../../../core/configs/themes/app_colors.dart';
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
        body: ListView.separated(
                padding: EdgeInsets.all(8),
                itemCount: creditCards.length,
                itemBuilder: (context, index) => ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  leading: Icon(FontAwesomeIcons.creditCard, color: AppColors.primary),
                  title: Text(AppFormat.cardnumber.format(int.parse(creditCards[index].cardNumber)).replaceAll(',', ' '), style: TextStyle(fontSize: 20, color: AppColors.primary)),
                  subtitle:  Text(creditCards[index].cardHolderName, style: TextStyle(fontSize: 12, color: AppColors.primary)),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 5),
                ),
      )
    
    );
  }
}