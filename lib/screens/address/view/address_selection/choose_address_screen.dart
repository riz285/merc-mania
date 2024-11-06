import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/common/widgets/cards/address_card.dart';

import '../../../../services/models/address.dart';
import '../../../order/view/confirm_order_screen.dart';
import '../../cubit/address_cubit.dart';
import '../add_address/add_address_page.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late List<Address> addresses;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    addresses = context.read<AddressCubit>().state.addresses;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressCubit, AddressState>(
      listener: (context, state) => setState(() {}),
      child: Column(
        children: [
          Expanded(
              child: ListView.separated(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) => SizedBox(
                      height: 100,
                      width: 100,
                      child: RadioListTile(
                        isThreeLine: true,
                        subtitle:  AddressCard(address: addresses[index]),
                        value: index, 
                        selected: index == selectedIndex,
                        groupValue: selectedIndex, 
                        onChanged: (value) => setState(() {
                          selectedIndex = value ?? 0;
                        })
                      )
                    ), 
                    separatorBuilder: (context, index) => SizedBox(width: 5),
              ),
            ),
          // Add new Address Button
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(children: [
              _AddNewProductButton(),
              SizedBox(height: 8),
              _NextButton(selectedAddress: addresses[selectedIndex]),
            ],)),
        ],)
    );
  }
}

class _AddNewProductButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('addressScreen_addAddress_raisedButton'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.red,
      ),
      onPressed: () {
        context.read<AddressCubit>().initState();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddAddressPage())
        );
      }, 
      child: Text('Add new address', style: TextStyle( color: Colors.white ))
      );
  }
}

class _NextButton extends StatelessWidget {
  final Address selectedAddress;
  const _NextButton({super.key, required this.selectedAddress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('addressScreen_next_raisedButton'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.red,
      ),
      onPressed: () {
        context.read<AddressCubit>().initState();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ConfirmOrderScreen(address: selectedAddress))
        );
      }, 
      child: Text('NEXT', style: TextStyle( color: Colors.white ))
      );
  }
}