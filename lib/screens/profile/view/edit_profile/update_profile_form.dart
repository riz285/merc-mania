import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:merc_mania/core/configs/assets/avatar.dart';
import '../../cubit/profile_cubit.dart';

class UpdateProfileForm extends StatefulWidget {
  const UpdateProfileForm({super.key});

  @override
  State<UpdateProfileForm> createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
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
              SnackBar(
                content: Text(state.errorMessage ?? 'Profile Update Failure'),
              ),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: ListView(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          shrinkWrap: true,
            children: [
                _AvatarInput(),
                const SizedBox(height: 30),
                Card(child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    _FirstNameInput(),
                    const SizedBox(height: 10),
                    _LastNameInput(),
                    const SizedBox(height: 10),
                    _PhoneNumberInput(),
                    const SizedBox(height: 10),
                    Align(child: _UpdateProfileButton()),
                  ]),
                ))
          ]),
      ),
    );
  }
}

class _AvatarInput extends StatefulWidget {
  @override
  State<_AvatarInput> createState() => _AvatarInputState();
}

class _AvatarInputState extends State<_AvatarInput> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
                onTap: () {
                  // context.read<ProfileCubit>().avatarChanged();
                },
                child: Align(
                  child: Stack(
                    children: [
                      Avatar(photo: context.read<ProfileCubit>().state.photo, size: 40),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  50,
                                ),
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(2, 4),
                                  color: Colors.black.withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 3,
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(Icons.add_a_photo, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
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
      onPressed: isValid
          ? () => context.read<ProfileCubit>().updateProfileFormSubmitted()
          : null,
      child: const Text('UPDATE'),
    );
  }
}