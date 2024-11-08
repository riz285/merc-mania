import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/screens/cart/view/cart_list_view.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/core/configs/assets/app_format.dart';
import 'package:merc_mania/screens/address/view/address_selection/choose_address_page.dart';
import 'package:merc_mania/screens/cart/cubit/cart_cubit.dart';
import 'package:merc_mania/screens/home/view/home_page.dart';
import 'package:merc_mania/screens/order/cubit/order_cubit.dart';
import 'package:merc_mania/screens/order/view/order_success_noti_screen.dart';
import 'package:merc_mania/screens/payment/view/choose_credit_card_bottom_sheet.dart';

import '../../../services/models/address.dart';


class ConfirmOrderScreen extends StatefulWidget {
  final Address address;
  const ConfirmOrderScreen({super.key, required this.address});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = context.select((CartCubit cartCubit) => cartCubit.state);
    return Scaffold(
          appBar: StyledAppBar(
            title: Text('Confirm Your Order'),
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                _AddressCard(address: widget.address),
                _CartCard(),
                _PaymentMethodCard(), // Choose Payment Method
                // Confirm Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: _ConfirmOrderButton(
                      onPressed: () {
                        context.read<OrderCubit>().checkOutOrder(cart.products, cart.total, widget.address);
                        context.read<CartCubit>().resetCart();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => OrderSuccessScreen())
                        );
                      }
                    ),
                  ),
                )
              ]),
            )
    );
  }
}

class _AddressCard extends StatelessWidget {
  final Address address;
  const _AddressCard({required this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text('Address: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text('${address.name}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                  VerticalDivider(),
                  Text('${address.phoneNum}')
                ]),
                Text('Ward: ${address.ward}   Street: ${address.street}'),
                Text('More: ${address.detail}', maxLines: 3),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    child: const Text('EDIT'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ChooseAddressPage())
                      );
                    }
                  ),
                )
            ]),
          ),
        ]
      ),
    );
  }
}

class _CartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.select((CartCubit cartCubit) => cartCubit.state);
    return Card(
      child: SizedBox(
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text('Item list:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Divider(),
            CartListView(products: cart.products),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                Text('Number of items: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('${cart.quantity}'),
                Spacer(),
                Text('Total: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),   
                Text(AppFormat.currency.format(cart.total)),  
              ],),
            ),
        ],),
      ),
    );
  }
}

class _PaymentMethodCard extends StatefulWidget {
  const _PaymentMethodCard();

  @override
  State<_PaymentMethodCard> createState() => __PaymentMethodCardState();
}

class __PaymentMethodCardState extends State<_PaymentMethodCard> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text('Payment method:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Divider(),
            RadioListTile(
              value: 0, 
              title: Text('Cash On Delivery (COD)'),
              groupValue: selectedIndex, 
              onChanged: (value) => setState(() {
                          selectedIndex = value ?? 0;
                        })
            ),
            SizedBox(height: 8),
            RadioListTile(
              value: 1, 
              title: Text('Credit Card'),
              groupValue: selectedIndex, 
              onChanged: (value) { 
                setState(() {
                  selectedIndex = value ?? 0;
                });
                showModalBottomSheet(
                  context: context, 
                  builder: (BuildContext context) {
                    return ChooseCreditCardBottomSheet();
                });
              },
            ),
            SizedBox(height: 8),
            RadioListTile(
              value: 2, 
              title: Text('PayPal'),
              groupValue: selectedIndex,  
              onChanged: (value) => setState(() {
                          selectedIndex = value ?? 0;
                        })
            ),
            SizedBox(height: 8),
          ],
        ),
      )
    );
  }
}

class _ConfirmOrderButton extends StatelessWidget {
  final Function() onPressed;
  const _ConfirmOrderButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('order_confirm_raisedButton'),
      onPressed: onPressed, 
      child: Text('CONFIRM'),
    );
  }
}