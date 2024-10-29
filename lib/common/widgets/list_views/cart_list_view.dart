import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/common/widgets/cards/cart_item_cart.dart';

import '../../../screens/cart/cubit/cart_cubit.dart';

class CartListView extends StatelessWidget {
  const CartListView({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = BlocProvider.of<CartCubit>(context);
    return Expanded(
      child: ListView.separated(
              itemCount: cart.state.products.length,
              itemBuilder: (context, index) => CartItemCard(product: cart.state.products[index]), 
              separatorBuilder: (context, index) => SizedBox(width: 5),
      ),
    );
  }
}