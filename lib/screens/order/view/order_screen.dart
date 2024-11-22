import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/screens/order/cubit/order_cubit.dart';
import 'package:merc_mania/services/database/order_service.dart';

import '../../../app/bloc/app_bloc.dart';
import 'order_list_view.dart';
import '../../../services/models/order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final orderService = OrderService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Fetch recent Product list
  Future<QuerySnapshot<Map<String, dynamic>>> fetchData() async {
    final userId = context.read<AppBloc>().state.user.id;
    return orderService.getAppOrders(userId);
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<OrderCubit, OrderState>(
      builder: (BuildContext context, OrderState state) {  
        return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future:  fetchData(), 
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
      },
    );
  }
}