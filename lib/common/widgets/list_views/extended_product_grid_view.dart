import 'package:flutter/material.dart';

import '../cards/product_card.dart';
import '../../../services/models/product.dart';

class ProductGridView extends StatelessWidget {
  final List<Product> products;
  const ProductGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap : true,
      itemCount: 8,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: ProductCard(product: products[index]),
      ), 
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        crossAxisSpacing: 10, 
        mainAxisSpacing: 10), 
    );    
  }
}