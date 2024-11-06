import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../cubit/address_cubit.dart';

class AddAddressForm extends StatelessWidget {
  const AddAddressForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Address Added Failure'),
              ),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // _CountryInput(),
              // const SizedBox(height: 8),
              // _ProvinceInput(),
              // const SizedBox(height: 8),
              // _CityInput(),
              // const SizedBox(height: 8),
              _WardInput(),
              const SizedBox(height: 8),
              _StreetInput(),
              const SizedBox(height: 8),
              _AddressDetailInput(),
              const SizedBox(height: 8),
              _NameInput(),
              const SizedBox(height: 8),
              _PhoneNumberInput(),
              const SizedBox(height: 8),
              _AddNewAddressButton()
            ],
          ),
        ),
      )
    );
  }
}

class _WardInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('addAddressForm_wardInput_textField'),
      onChanged: (ward) => context.read<AddressCubit>().wardNameChanged(ward),
      decoration: InputDecoration(
        labelText: 'ward',
      ),
    );
  }
}

class _StreetInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('addAddressForm_streetInput_textField'),
      onChanged: (street) => context.read<AddressCubit>().streetNameChanged(street),
      decoration: InputDecoration(
        labelText: 'street',
      ),
    );
  }
}

class _AddressDetailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('addAddressForm_addressDetailInput_textField'),
      onChanged: (detail) => context.read<AddressCubit>().addressDetailChanged(detail),
      decoration: InputDecoration(
        labelText: 'address details',
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
        (AddressCubit cubit) => cubit.state.name.displayError,
      ); 
    
    return TextField(
      key: const Key('addAddressForm_nameInput_textField'),
      onChanged: (name) => context.read<AddressCubit>().nameChanged(name),
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: 'recipient name',
        helperText: '',
        errorText: displayError != null ? 'invalid name' : null,
      ),
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
        (AddressCubit cubit) => cubit.state.phoneNum.displayError,
      ); 
    
    return TextField(
      key: const Key('addAddressForm_phoneNumberInput_textField'),
      onChanged: (phoneNum) => context.read<AddressCubit>().phoneNumberChanged(phoneNum),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'phone number',
        helperText: '',
        errorText: displayError != null ? 'invalid phone number' : null,
      ),
    );
  }
}

class _AddNewAddressButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (AddressCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (AddressCubit cubit) => cubit.state.isValid,
    );

    return ElevatedButton(
      key: const Key('addAddressForm_addAddress_raisedButton'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      onPressed: isValid
          ? () => context.read<AddressCubit>().addAddressFormSubmitted()
          : null,
      child: const Text('ADD'),
    );
  }
}