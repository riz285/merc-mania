import 'package:flutter/material.dart';
import 'package:merc_mania/screens/order/view/order_screen.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
        ),
        body: OrderScreen()
    );
  }
}