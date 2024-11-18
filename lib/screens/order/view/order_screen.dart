import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/screens/order/cubit/order_cubit.dart';
import 'package:merc_mania/services/database/order_service.dart';

import '../../../app/bloc/app_bloc.dart';
import 'order_list_view.dart';
import '../../../services/models/order.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<OrderCubit, OrderState>(
      builder: (BuildContext context, OrderState state) {  
        return _OrderListView();
      },
    );
  }
}

class _OrderListView extends StatelessWidget {
  const _OrderListView();

  @override
  Widget build(BuildContext context) {
    final orderService = OrderService();
    final userId = context.select((AppBloc bloc) => bloc.state.user.id);
    //Sizebox height?
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future:  orderService.getAppOrders(userId), 
            builder: (builder, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              if (snapshot.hasData) {
                final orders = snapshot.data!.docs.map((doc) => AppOrder.fromJson(doc.data())).toList();
                return orders.isNotEmpty ? OrderListView(orders: orders) : Align(child: Text('No order history yet!'));
              }                                    
              return Container();    
            }
    );
  }
}