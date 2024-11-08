import 'package:flutter/material.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(
        title: Text('My addresses'),
      ),
      body: Placeholder(),
    );
  }
}