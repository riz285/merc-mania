import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/configs/assets/app_format.dart';
import '../cubit/cart_cubit.dart';
import '../../product_display/view/product_detail.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              Align(
                alignment: Alignment(1, 1),
                child: TextButton(
                  child: const Text('REMOVE'),
                  onPressed: () {
                    cart.removeFromCart(product);
                  },
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}