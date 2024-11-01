import 'package:flutter/material.dart';
import 'package:merc_mania/services/models/order.dart';

import '../../../core/configs/assets/app_format.dart';

class OrderCard extends StatelessWidget {
  final UserOrder order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => OrderDetail(order: order),
        //     ),
        // );
      },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(order.id),
              subtitle: Text(AppFormat.currency.format(order.total)),
            ),
          ],
        ),
      )
    );
  }
}