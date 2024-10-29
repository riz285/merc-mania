import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/screens/cart/cubit/cart_cubit.dart';

import '../../../common/widgets/cards/order_card.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = BlocProvider.of<CartCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Column(
        children: [
          Visibility(
            visible: (cart.state.orders.isNotEmpty),
            replacement: Text('[Empty.]'),
            child: Expanded(
              child: ListView.separated(
                itemCount: cart.state.products.length,
                itemBuilder: (context, index) => OrderCard(order: cart.state.orders[index]), 
                separatorBuilder: (context, index) => SizedBox(width: 5),
              ),
            ),
          )
        ],
      )
    );
  }
}