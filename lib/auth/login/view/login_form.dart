import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:merc_mania/auth/reset_password/view/reset_password_page.dart';

import '../../sign_up/view/sign_up_page.dart';
import '../cubit/login_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, 0),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                  'assets/images/butterfly.png',
                  height: 100,
              ),
              const SizedBox(height: 16),
              _EmailInput(),
              const SizedBox(height: 8),
              _PasswordInput(),
              Align(
                alignment: Alignment.topRight,
                child: _ForgetPassword()),
              const SizedBox(height: 8),
              _LoginButton(),
              const SizedBox(height: 8),
              Text('Don\'t have an account? Create one!'),
              _SignUpButton(),
              Divider(thickness: 2),
              const SizedBox(height: 16),
              _GoogleLoginButton(),
              _FacebookLoginButton()
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
      (LoginCubit cubit) => cubit.state.email.displayError,
    );

    return TextField(
      key: const Key('loginForm_emailInput_textField'),
      onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'email',
        helperText: '',
        errorText: displayError != null ? 'invalid email' : null,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginCubit cubit) => cubit.state.password.displayError,
    );

    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (password) =>
          context.read<LoginCubit>().passwordChanged(password),
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'password',
        helperText: '',
        errorText: displayError != null ? 'invalid password' : null,
      ),
    );
  }
}

class _ForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ResetPasswordPage()));
      }, 
      child: Text(
        'forget password',
        style: TextStyle(
          fontSize: 14,
          color: const Color.fromARGB(150, 255, 255, 255),
          fontStyle: FontStyle.italic, 
          decoration: TextDecoration.underline
        )
      )
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (LoginCubit cubit) => cubit.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (LoginCubit cubit) => cubit.state.isValid,
    );

    return ElevatedButton(
      key: const Key('loginForm_continue_raisedButton'),
      onPressed: isValid
          ? () => context.read<LoginCubit>().logInWithCredentials()
          : null,
      child: const Text('LOGIN'),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      key: const Key('loginForm_googleLogin_raisedButton'),
      label: const Text(
        'SIGN IN WITH GOOGLE',
        style: TextStyle(color: Color.fromARGB(250, 255, 255, 255)),
      ),
      icon: const Icon(FontAwesomeIcons.google, color: Color.fromARGB(250, 255, 255, 255)),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    );
  }
}

class _FacebookLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      key: const Key('loginForm_facebookLogin_raisedButton'),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.blue),
      ),
      label: const Text(
        'SIGN IN WITH FACEBOOK',
        style: TextStyle(color: Color.fromARGB(250, 255, 255, 255)),
      ),
      icon: const Icon(FontAwesomeIcons.facebook, color: Color.fromARGB(250, 255, 255, 255)),
      onPressed: () {},
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      style: ButtonStyle(visualDensity: VisualDensity.compact),
      onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SignUpPage())),
      child: Text('CREATE ACCOUNT'),
    );
  }
}