import 'package:flutter/material.dart';

import '../../../product_display/view/product_card.dart';
import '../../../../services/models/product.dart';

class ProductListView extends StatelessWidget {
  final List<Product> products;
  const ProductListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length < 8 ? products.length : 8,
            itemBuilder: (context, index) => ProductCard(product: products[index]), 
            separatorBuilder: (context, index) => SizedBox(width: 5),
    );
  }
}