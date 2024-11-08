import 'package:flutter/material.dart';

class PaymentMethodSelection extends StatefulWidget {
  const PaymentMethodSelection({super.key});

  @override
  State<PaymentMethodSelection> createState() => _PaymentMethodSelectionState();
}

class _PaymentMethodSelectionState extends State<PaymentMethodSelection> {
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
              title: Card(
                child: Text('Cash On Delivery (COD)'),
              ),
              groupValue: selectedIndex, 
              onChanged: (value) => setState(() {
                          selectedIndex = value ?? 0;
                        })
            ),
            SizedBox(height: 8),
            RadioListTile(
              value: 1, 
              title: Card(
                child: Text('Credit Card'),
              ),
              groupValue: selectedIndex, 
              onChanged: (value) => setState(() {
                          selectedIndex = value ?? 0;
                        })
            ),
            SizedBox(height: 8),
            RadioListTile(
              value: 2, 
              title: Card(
                child: Text('PayPal'),
              ),
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