import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:formz/formz.dart';
import 'package:merc_mania/consts.dart';
import 'package:merc_mania/screens/cart/view/cart_list_view.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/core/configs/assets/app_format.dart';
import 'package:merc_mania/screens/address/view/address_selection/choose_address_page.dart';
import 'package:merc_mania/screens/cart/cubit/cart_cubit.dart';
import 'package:merc_mania/screens/order/cubit/order_cubit.dart';
import 'package:merc_mania/screens/order/view/order_success_noti_screen.dart';

import '../../../services/models/address.dart';
import '../../notifications/cubit/notifications_cubit.dart';


class ConfirmOrderScreen extends StatefulWidget {
  final Address address;
  const ConfirmOrderScreen({super.key, required this.address});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Payment Failure'),
              ),
            );
        } else if (state.status.isSuccess) {
          context.read<NotificationCubit>().alertAboutNewOrder(context.read<OrderCubit>().state.orderId);
          context.read<CartCubit>().state.product==null 
          ? context.read<CartCubit>().resetCart() : context.read<CartCubit>().deleteFromPurchase();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Payment Processed Successfully'),
              ),
            );
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => OrderSuccessScreen())
          );
        }
      },
      child: Scaffold(
              appBar: StyledAppBar(
                title: Text('Confirm Your Order'),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                    _AddressCard(address: widget.address),
                    _CartCard(),
                    _PaymentMethodCard(address: widget.address), // Choose Payment Method 
                    // Confirm Button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: _ConfirmOrderButton(address: widget.address),
                      ),
                    )
                  ]),
                )
      ),
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
        child: (cart.product==null) 
        ? Column(
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
        ],)
        : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text('Item list:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Divider(),
            CartListView(products: cart.product??List.empty()),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                Text('Number of items: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('1'),
                Spacer(),
                Text('Total: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),   
                Text(AppFormat.currency.format(cart.price)),  
              ],),
            ),
        ],),
      ),
    );
  }
}

class _PaymentMethodCard extends StatefulWidget {
  final Address address;
  const _PaymentMethodCard({required this.address});
  @override
  State<_PaymentMethodCard> createState() => __PaymentMethodCardState();
}

class __PaymentMethodCardState extends State<_PaymentMethodCard> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final cart = context.select((CartCubit cartCubit) => cartCubit.state);
    return Card(
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
              onChanged: (value) async { 
                setState(() {
                  selectedIndex = value ?? 0;
                });
                await context.read<OrderCubit>().cardPaymentProcess(cart.price??cart.total, cart.product??cart.products, widget.address);
              },
            ),
            SizedBox(height: 8),
            RadioListTile(
              value: 2, 
              title: Text('PayPal'),
              groupValue: selectedIndex,  
              onChanged: (value) => setState(() {
                          selectedIndex = value ?? 0;
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                            PaypalPaymentScreen(address: widget.address)));
                        })
            ),
            SizedBox(height: 8),
          ],
        ),
    );
  }
}

class _ConfirmOrderButton extends StatelessWidget {
  final Address address;
  const _ConfirmOrderButton({required this.address});

  @override
  Widget build(BuildContext context) {
    final cart = context.select((CartCubit cartCubit) => cartCubit.state);
    return ElevatedButton(
      key: const Key('order_confirm_raisedButton'),
      onPressed: () {
        context.read<OrderCubit>().cashPaymentProcess(cart.price??cart.total, cart.product??cart.products, address);
      }, 
      child: Text('CONFIRM'),
    );
  }
}

class PaypalPaymentScreen extends StatelessWidget {
  final Address address;
  const PaypalPaymentScreen({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final cart = context.select((CartCubit cartCubit) => cartCubit.state);
    final order = context.select((OrderCubit cartCubit) => cartCubit);
    final amount = cart.price??cart.total;
    return UsePaypal(
      sandboxMode: true,
      clientId:
          paypalApiKey,
      secretKey:
          paypalSecretKey,
      returnURL: "https://samplesite.com/return",
      cancelURL: "https://samplesite.com/cancel",
      transactions: [
      {
        "amount": {
          "total": int.parse(((double.parse(amount.toString()))/23000).round().toString()),
          "currency": "USD",
        },
        "description":
            "The payment transaction description.",
        // "payment_options": {
        //   "allowed_payment_method":
        //       "INSTANT_FUNDING_SOURCE"
        // },
        "item_list": {
          "items": [
            {
              "name": "A demo product",
              "quantity": 1,
              "price": int.parse(((double.parse(amount.toString()))/23000).round().toString()),
              "currency": "USD"
            }
          ],
        }
      }
    ],
    note: "Contact us for any questions on your order.",
    onSuccess: (Map params) async {
      order.paypalPaymentProcess(amount, cart.product??cart.products, address);
    },
    onError: (error) {
      ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Payment Failure'),
              ),
            );
            Navigator.of(context).pop;
    },
    onCancel: (params) {
      ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Payment Failure'),
              ),
            );
    });
  }
}