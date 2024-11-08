import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:merc_mania/screens/address/view/address_selection/choose_address_page.dart';
import 'package:merc_mania/screens/cart/view/cart_list_view.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/core/configs/assets/app_format.dart';

import '../cubit/cart_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final products = context.select((CartCubit cubit) => cubit.state.products);
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) => setState(() {}),
      child: Scaffold(
        appBar: StyledAppBar(
          title: Text('Cart'),
        ),
        body: Column(
          children: [
            CartListView(products: products),
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
    final isInProgress = context.select(
      (CartCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (CartCubit cubit) => cubit.state.isValid,
    );

    return ElevatedButton(
      key: const Key('cart_next_raisedButton'),
      onPressed: isValid 
                  ? () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ChooseAddressPage())
                  ) : null,
      child: Text('CHECK OUT'),
    );
  }
}