import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../cubit/reset_password_cubit.dart';

class ResetPasswordForm extends StatefulWidget {
  final String email;
  const ResetPasswordForm({required this.email, super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.pop(context);
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Reset password Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _EmailInput(),
              const SizedBox(height: 8),
              _ResetPasswordButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (ResetPasswordCubit cubit) => cubit.state.email.displayError,
    );

    return TextField(
      key: const Key('signUpForm_emailInput_textField'),
      onChanged: (email) => context.read<ResetPasswordCubit>().emailChanged(email),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'email',
        helperText: '',
        errorText: displayError != null ? 'invalid email' : null,
      ),
    );
  }
}


class _ResetPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (ResetPasswordCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (ResetPasswordCubit cubit) => cubit.state.isValid,
    );

    return ElevatedButton(
      key: const Key('ResetPasswordForm_continue_raisedButton'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      onPressed: isValid
          ? () => context.read<ResetPasswordCubit>().resetPasswordFormSubmitted()
          : null,
      child: const Text('RESET PASSWORD'),
    );
  }
}