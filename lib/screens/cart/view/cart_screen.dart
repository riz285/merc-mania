import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/common/widgets/list_views/cart_list_view.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/core/configs/assets/app_format.dart';

import '../../address/view/address_display/address_page.dart';
import '../cubit/cart_cubit.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state.status == Status.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Cart empty'),
              ),
            );
        }
        setState(() {
          
        });
      },
    child: Scaffold(
        appBar: StyledAppBar(
          title: Text('Cart'),
        ),
        body: Column(
          children: [
            CartListView(),
            Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Row(children: [
                  Text('Total: ', style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16
                    ),
                  ),
                  Text(AppFormat.currency.format(context.read<CartCubit>().state.total)),
                  Spacer(),
                  _CheckOutButton()
                ],),
              ),
            )
          ],
        )
      )
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
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddressPage())
        );
      }, 
      child: Text('CHECK OUT', style: TextStyle( color: Colors.white )),
    );
  }
}