import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/models/address.dart';
import '../../../order/view/confirm_order_screen.dart';
import '../../cubit/address_cubit.dart';
import '../add_address/add_address_page.dart';
import '../address_card.dart';

class ChooseAddressScreen extends StatefulWidget {
  const ChooseAddressScreen({super.key});

  @override
  State<ChooseAddressScreen> createState() => _ChooseAddressScreenState();
}

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  late List<Address> addresses;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final addresses = context.select((AddressCubit cubit) => cubit.state.addresses);
    return BlocListener<AddressCubit, AddressState>(
      listener: (context, state) => setState(() {}),
      child: Align(
        alignment: const Alignment(-1, -1),
        child: Column(
          children: [
            Expanded(child: Column(children: [
              ListView.separated(
              shrinkWrap: true,
                itemCount: addresses.length,
                itemBuilder: (context, index) => SizedBox(
                  height: 100,
                  width: 100,
                  child: ListTile(
                    isThreeLine: true,
                    subtitle:  AddressCard(address: addresses[index]),
                    focusColor: Colors.pink,
                    selected: index == selectedIndex,
                    onTap: () => setState(() {
                      selectedIndex = index;
                    })
                  )
                ), 
                separatorBuilder: (context, index) => SizedBox(width: 5),
                ),
              // Add new Address Button
              Align(child: _AddNewAddressButton()),
            ])),
            addresses.isNotEmpty ?
            Padding(
              padding: EdgeInsets.all(30),
              child: _NextButton(selectedAddress: addresses[selectedIndex])) : Container()
          ],
        ),
      )
    );
  }
}

class _AddNewAddressButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('addressScreen_addAddress_textButton'),
      onPressed: () {
        context.read<AddressCubit>().initState();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddAddressPage())
        );
      }, 
      child: Text('Add new address')
      );
  }
}

class _NextButton extends StatelessWidget {
  final Address selectedAddress;
  const _NextButton({required this.selectedAddress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('addressScreen_next_raisedButton'),
      onPressed: () {
        context.read<AddressCubit>().initState();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ConfirmOrderScreen(address: selectedAddress))
        );
      }, 
      child: Text('NEXT')
      );
  }
}