// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/screens/address/view/add_address/add_address_form.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(
        title: Text('Add new address'),
      ),
      body: AddAddressForm()
    );
  }
}
