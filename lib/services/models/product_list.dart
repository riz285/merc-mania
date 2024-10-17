import 'package:flutter/material.dart';

import '../../common/widgets/styled_product_card.dart';
import 'product.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
            scrollDirection: Axis.horizontal,
            // TODO: fix itemCount
            itemCount: products.length,
            itemBuilder: (context, index) => StyledProductCard(product: products[index]), 
            separatorBuilder: (context, index) => SizedBox(width: 5),
    );
  }
}