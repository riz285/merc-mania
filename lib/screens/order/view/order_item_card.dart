import 'package:flutter/material.dart';

import '../../../core/configs/assets/app_format.dart';
import '../../product_display/view/product_detail.dart';
import '../../../services/models/product.dart';

class OrderItemCard extends StatelessWidget {
  final Product product;
  const OrderItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // final user = context.select((AppBloc bloc) => bloc.state.user);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetail(product: product),
            ),
        );
      },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              // Product Image
              leading: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey[700],
                  image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(product.image))
                ),
              ),
              title: Text(product.name),
              subtitle: Text(AppFormat.currency.format(product.price)),
            ),
          ],
        ),
      )
    );
  }
}