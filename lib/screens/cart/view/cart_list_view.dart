import 'package:flutter/material.dart';
import 'package:merc_mania/screens/cart/view/cart_item_card.dart';
import 'package:merc_mania/services/models/product.dart';

class CartListView extends StatelessWidget {
  final List<Product> products;
  const CartListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
              itemCount: products.length,
              itemBuilder: (context, index) => CartItemCard(product: products[index]), 
              separatorBuilder: (context, index) => SizedBox(width: 5),
      ),
    );
  }
}