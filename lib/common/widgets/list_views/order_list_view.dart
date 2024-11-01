import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/order/cubit/order_cubit.dart';
import '../cards/order_card.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<OrderCubit>(context).state;
    return Expanded(
      child: ListView.separated(
              itemCount: state.orders.length,
              itemBuilder: (context, index) => OrderCard(order: state.orders[index]), 
              separatorBuilder: (context, index) => SizedBox(width: 5),
      ),
    );
  }
}