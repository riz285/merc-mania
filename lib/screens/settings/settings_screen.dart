import 'package:flutter/material.dart';
import 'package:merc_mania/screens/payment/view/credit_card_screen.dart';
import 'package:merc_mania/screens/security/security.dart';

import '../address/view/address_display/address_page.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      children: [
        Column(children: [
          Text('Account Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ListTile(
            title: Text('Security'),
            onTap: () { 
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Security()));
            }),
          ListTile(
            title: Text('Address'),
            onTap: () { 
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddressPage()));
              }
            )
        ]),
        Divider(),
        Column(children: [
          Text('Manage Finances', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ListTile(
            title: Text('Credit Card'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CreditCardScreen()));
              }),
          ListTile(
            title: Text('PayPal'),
            onTap: () { 
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => AddressPage()));
              }
            )
        ]),
        Divider(),
        Column(children: [
          Text('Other Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ListTile(
            title: Text('Chat Settings'),
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => CreditCardScreen()));
              }),
          ListTile(
            title: Text('Notification Settings'),
            onTap: () { 
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => AddressPage()));
              }
            ),
          ListTile(
            title: Text('Language'),
            onTap: () {},
          ),
        ]),
      ],
    );
  }
}