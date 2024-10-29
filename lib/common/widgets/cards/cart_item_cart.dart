import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/configs/assets/app_format.dart';
import '../../../screens/cart/cubit/cart_cubit.dart';
import '../../../screens/product_display/view/product_detail.dart';
import '../../../services/models/product.dart';

class CartItemCard extends StatelessWidget {
  final Product product;
  const CartItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = BlocProvider.of<CartCubit>(context);
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
                )
              ),
              title: Text(product.name),
              subtitle: Text(AppFormat.currency.format(product.price)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('REMOVE'),
                  onPressed: () {
                    cart.removeFromCart(product);
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      )
    );
  }
}