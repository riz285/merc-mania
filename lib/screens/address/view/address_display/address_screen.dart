import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/models/address.dart';
import '../../cubit/address_cubit.dart';
import '../add_address/add_address_page.dart';
import '../address_card.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late List<Address> addresses;
  @override
  Widget build(BuildContext context) {
    final addresses = context.select((AddressCubit cubit) => cubit.state.addresses);
    return BlocListener<AddressCubit, AddressState>(
      listener: (context, state) => setState(() {}),
      child: Align(
        alignment: const Alignment(-1, -1),
        child: Column(
          children: [
            Expanded( child: 
              ListView.separated(
              shrinkWrap: true,
                itemCount: addresses.length,
                itemBuilder: (context, index) => SizedBox(
                  height: 100,
                  width: 100,
                  child: ListTile(
                    selectedTileColor: Colors.grey[850],
                    isThreeLine: true,
                    subtitle:  AddressCard(address: addresses[index]),
                    ),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 5),
                ),
              ),
            
              // Add new Address Button
              Align(child: _AddNewAddressButton()),
            ])),
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