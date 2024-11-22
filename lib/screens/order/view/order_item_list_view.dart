import 'package:flutter/material.dart';
import 'package:merc_mania/services/models/product.dart';

import 'order_item_card.dart';

class OrderItemListView extends StatelessWidget {
  final List<Product> products;
  const OrderItemListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
              itemCount: products.length,
              itemBuilder: (context, index) => OrderItemCard(product: products[index]), 
              separatorBuilder: (context, index) => SizedBox(width: 5),
    );
  }
}