import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/screens/order/cubit/order_cubit.dart';

import '../../../common/widgets/list_views/order_list_view.dart';
import '../../../core/configs/assets/app_format.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<OrderCubit, OrderState>(
      builder: (BuildContext context, OrderState state) {  
        return Column(
          children: [
            OrderListView(),
            Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Row(children: [
                  Text('Total: ', style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16
                    ),
                  ),
                  Text(AppFormat.currency.format(context.read<OrderCubit>().state.total)),
                  Spacer(),
                  _CheckOutButton()
                ],),
              ),
            )
          ],
        );
      },
    );
  }
}

class _CheckOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('cart_next_raisedButton'),
      style: ElevatedButton.styleFrom(
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.red,
      ),
      onPressed: () {}, 
      child: Text('CHECK OUT', style: TextStyle( color: Colors.white )),
    );
  }
}