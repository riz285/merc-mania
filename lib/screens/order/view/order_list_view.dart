import 'package:flutter/material.dart';
import 'package:merc_mania/services/models/order.dart';
import 'order_card.dart';

class OrderListView extends StatelessWidget {
  final List<AppOrder> orders;
  const OrderListView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
                itemCount: orders.length,
                itemBuilder: (context, index) => OrderCard(order: orders[index]), 
                separatorBuilder: (context, index) => SizedBox(width: 5),
    );
  }
}