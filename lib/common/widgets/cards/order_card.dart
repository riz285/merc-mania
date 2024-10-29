import 'package:flutter/material.dart';
import 'package:merc_mania/services/models/order.dart';

import '../../../core/configs/assets/app_format.dart';

class OrderCard extends StatelessWidget {
  final UserOrder order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.note),
              title: Text('Order number: ${order.id}'),
              subtitle: Text('Total: ${AppFormat.currency.format(order.total)} Date: ${order.createdAt} '),
            ),
          ],
        ),
    );
  }
}