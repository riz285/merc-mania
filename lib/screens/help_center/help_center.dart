import 'package:flutter/material.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center'),
      ),
      body: ListView(
          children: [
            Container(
              child: Column(children: [
                Text('Top Enquiries', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ))
              ],),
            ),
            Divider(),
            Container(
              child: Column(children: [
                Text('Frequently Asked', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ))
              ],),
            ),
            Divider(),
            Container(
              child: Column(children: [
                Text('More', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                )),
                Text('Chat with us'),
                Text('Call Hotline')
              ],),
            ),
          ],
        ),
    );
  }
}