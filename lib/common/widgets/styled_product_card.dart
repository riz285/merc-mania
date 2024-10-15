import 'package:flutter/material.dart';

import '../../services/models/product.dart';

class StyledProductCard extends StatelessWidget {
  final Product product;
  const StyledProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[700],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            Container(
              color: Colors.red,
              child: Text('50%', style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),),
            ),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border_outlined))
          ],),
          Image.network(product.image),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15))
            ),
            child: Text('${product.price}VND')),
        ],
      ),
    );
  }
}