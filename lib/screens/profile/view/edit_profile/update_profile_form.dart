import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../cubit/profile_cubit.dart';

class UpdateProfileForm extends StatelessWidget {
  const UpdateProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Update Profile Failure')),
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
              // Avatar
              Image.asset(
                  'assets/images/butterfly.png',
                  height: 100,
                ),
              const SizedBox(height: 8),
              _FirstNameInput(),
              const SizedBox(height: 8),
              _LastNameInput(),
              const SizedBox(height: 8),
              _PhoneNumberInput(),
              const SizedBox(height: 8),
              _UpdateProfileButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (ProfileCubit cubit) => cubit.state.firstName.displayError,
    );

    return TextField(
      key: const Key('updateProfileForm_firstNameInput_textField'),
      onChanged: (firstName) => context.read<ProfileCubit>().firstNameChanged(firstName),
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: 'first name',
        helperText: '',
        errorText: displayError != null ? 'invalid name' : null,
      ),
    );
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (ProfileCubit cubit) => cubit.state.lastName.displayError,
    );

    return TextField(
      key: const Key('updateProfileForm_lastNameInput_textField'),
      onChanged: (lastName) => context.read<ProfileCubit>().lastNameChanged(lastName),
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: 'last name',
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
      (ProfileCubit cubit) => cubit.state.phoneNum.displayError,
    );

    return TextField(
      key: const Key('updateProfileForm_phoneNumberInput_textField'),
      onChanged: (phoneNum) => context.read<ProfileCubit>().phoneNumberChanged(phoneNum),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'phone number',
        helperText: '',
        errorText: displayError != null ? 'invalid phone number' : null,
      ),
    );
  }
}

class _UpdateProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (ProfileCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (ProfileCubit cubit) => cubit.state.isValid,
    );

    return ElevatedButton(
      key: const Key('updateProfileForm_continue_raisedButton'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      onPressed: isValid
          ? () => context.read<ProfileCubit>().updateProfileFormSubmitted()
          : null,
      child: const Text('UPDATE'),
    );
  }
}