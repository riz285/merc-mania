// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/screens/address/view/address_selection/choose_address_screen.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(
        title: Text('Choose your address'),
      ),
      body: AddressScreen()
    );
  }
}
