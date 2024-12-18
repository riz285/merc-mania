import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';

import '../cubit/reset_password_cubit.dart';
import 'reset_password_form.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: ResetPasswordPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(
        title: const Text('Forget Password')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => ResetPasswordCubit(context.read<AuthenticationRepository>()),
          child: const ResetPasswordForm(),
        ),
      ),
    );
  }
}