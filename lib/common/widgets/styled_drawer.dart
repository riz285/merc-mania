import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/screens/help_center/help_center.dart';
import 'package:merc_mania/screens/policy/policy.dart';
import 'package:merc_mania/screens/security/security.dart';

import '../../app/bloc/app_bloc.dart';
import '../../core/configs/assets/app_images.dart';
import '../../screens/profile/view/profile.dart';
import '../../screens/settings/settings.dart';

class StyledDrawer extends StatelessWidget {
  const StyledDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Expanded(child: ListView(
        children: [
        DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.pinkAccent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(AppImages.logoImage,
                height: 50),
                const Text('Name',
                style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
        ListTile(
          onTap: () { 
            Navigator.pop(context);
            Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Profile(),
            )
          );
          },
          leading: Icon(Icons.person),
          title: Text('Personal Information'),
        ),
        ListTile(
          onTap: () { 
            Navigator.pop(context);
            Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Security(),
            )
          );
          },
          leading: Icon(Icons.lock),
          title: Text('Security'),
        ),
        ListTile(
          onTap: () { 
            Navigator.pop(context);
            Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HelpCenter(),
            )
          );
          },
          leading: Icon(Icons.help),
          title: Text('Help Center'),
        ),
        ListTile(
          onTap: () { 
            Navigator.pop(context);
            Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Policy(),
            )
          );
          },
          leading: Icon(Icons.policy),
          title: Text('Policies & Agreements'),
        ),])
        ),
        Align(
          child: Row(children: [
            IconButton(
              key: const Key('drawer_settings_iconButton'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Settings()
                    ));},
              icon: Icon(Icons.settings)
            ),
            Spacer(),
            IconButton(
              key: const Key('drawer_logout_iconButton'),
              onPressed: () {
                context.read<AppBloc>().add(const AppLogoutPressed());
              }, icon: Icon(Icons.logout))
              ]),
          ),
        ]
      )
    );
  }
}