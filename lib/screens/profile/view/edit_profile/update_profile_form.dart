import 'package:cloud_firestore/cloud_firestore.dart';
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
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Fetch current user data
  Future<DocumentSnapshot<Map<String, dynamic>>?> fetchUserData() async {
    try {
      return await context.read<ProfileCubit>().fetchUserData();
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching user data: $e');
      return null;
    }
  }
  
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
      child: FutureBuilder(
        future: fetchUserData(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center();
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          final data = snapshot.data!.data()!;
          return Align(
            alignment: const Alignment(0, -1 / 3),
            child: ListView(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              shrinkWrap: true,
              children: [
                _AvatarInput(photo: data['photo']),
                const SizedBox(height: 30),
                Card(child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    _FirstNameInput(firstName: data['first_name']),
                    const SizedBox(height: 10),
                    _LastNameInput(lastName: data['last_name']),
                    const SizedBox(height: 10),
                    _PhoneNumberInput(phoneNum: data['phone_number']),
                    const SizedBox(height: 10),
                    Align(child: _UpdateProfileButton()),
                  ]),
                ))
              ]
            ),
          );
        }),
    );
  }
}

class _AvatarInput extends StatefulWidget {
  final String photo;
  const _AvatarInput({required this.photo});
  @override
  State<_AvatarInput> createState() => _AvatarInputState();
}

class _AvatarInputState extends State<_AvatarInput> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                onTap: () {
                  context.read<ProfileCubit>().avatarChanged();
                },
                child: Align(
                  child: Stack(
                    children: [
                      Avatar(photo: context.read<ProfileCubit>().state.photo??widget.photo, size: 40),
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
  final String firstName;
  const _FirstNameInput({required this.firstName});

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
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'first name', 
        hintText: firstName,
        errorText: displayError != null ? 'invalid name' : null,
      ),
    );
  }
}

class _LastNameInput extends StatelessWidget {
  final String lastName;
  const _LastNameInput({required this.lastName});

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
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'last name',
        hintText: lastName,
        errorText: displayError != null ? 'invalid name' : null,
      ),
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  final String phoneNum;
  const _PhoneNumberInput({required this.phoneNum});

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
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'phone number',
        hintText: phoneNum,
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