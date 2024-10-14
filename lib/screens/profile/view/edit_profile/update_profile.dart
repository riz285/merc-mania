import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/profile_cubit.dart';
import 'update_profile_form.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const UpdateProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<ProfileCubit>(
          create: (_) => ProfileCubit(context.read<AuthenticationRepository>()),
          child: const UpdateProfileForm(),
        ),
      ),
    );
  }
}