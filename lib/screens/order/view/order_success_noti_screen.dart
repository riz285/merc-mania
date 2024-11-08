import 'package:flutter/material.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/screens/home/view/home_page.dart';
import 'package:merc_mania/screens/order/view/order_page.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(
        title: Text('Notification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('Congratulations!\nYou have successfully place an order.'),
          Row(children: [
            TextButton(
            onPressed: () { 
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => OrderPage())
              );
             },
            child: Text('Order Screen')
          ),
          Spacer(),
          TextButton(
            onPressed: () { 
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage())
              );
             },
            child: Text('Home')
          )
          ])
        ])
      ),
    );
  }
}