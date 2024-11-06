import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../screens/address/cubit/address_cubit.dart';
import '../../../services/models/address.dart';

class AddressCard extends StatelessWidget {
  final Address address;
  const AddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(children: [
                  Text('${address.name}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                  VerticalDivider(),
                  Text('${address.phoneNum}')
                ]),
                Text('Ward: ${address.ward}   Street: ${address.street}'),
                Text('Details: ${address.detail}', maxLines: 3),
              ]),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                child: const Text('REMOVE'),
                onPressed: () {
                  context.read<AddressCubit>().removeAddress(address);
                },
              ),
            ),
          ],
        ),
    );
  }
}