import 'package:flutter/material.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';

class Security extends StatelessWidget {
  const Security({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(
        title: Text('Security'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(children: [
          ListTile(
            title: Text('Change Password'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Link with a different email'),
            onTap: () {}),
        ],),
      )
    );
  }
}