import 'package:flutter/material.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'update_profile_form.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const UpdateProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: StyledAppBar(
            title: Text('Update Profile'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: UpdateProfileForm())
      );
  }
}