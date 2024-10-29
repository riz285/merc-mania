import 'package:flutter/material.dart';

class AddAddressForm extends StatelessWidget {
  const AddAddressForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
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
      );
  }
}

class _WardInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('signUpForm_emailInput_textField'),
      onChanged: (ward) => {},
      keyboardType: TextInputType.emailAddress,
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
      key: const Key('signUpForm_emailInput_textField'),
      onChanged: (ward) => {},
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'ward',
      ),
    );
  }
}

class _AddressDetailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('signUpForm_emailInput_textField'),
      onChanged: (ward) => {},
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'ward',
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('updateProfileForm_lastNameInput_textField'),
      // onChanged: (name) => context.read<AddressCubit>().lastNameChanged(lastName),
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: 'recipient name',
      ),
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('updateProfileForm_phoneNumberInput_textField'),
      // onChanged: (phoneNum) => context.read<AddressCubit>().phoneNumberChanged(phoneNum),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'phone number',
      ),
    );
  }
}

class _AddNewAddressButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('signUpForm_continue_raisedButton'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      onPressed: () {},
      child: const Text('ADD ADDRESS'),
    );
  }
}