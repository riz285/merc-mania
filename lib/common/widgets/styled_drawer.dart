import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/core/configs/assets/avatar.dart';
import 'package:merc_mania/core/configs/themes/app_colors.dart';
import 'package:merc_mania/screens/help_center/help_center.dart';
import 'package:merc_mania/screens/policy/policy.dart';
import 'package:merc_mania/screens/theme_modes/cubit/theme_cubit.dart';

import '../../app/bloc/app_bloc.dart';
import '../../screens/profile/view/profile_display/profile_page.dart';
import '../../screens/settings/settings.dart';
import 'styled_switch.dart';

class StyledDrawer extends StatefulWidget {
  const StyledDrawer({super.key});

  @override
  State<StyledDrawer> createState() => _StyledDrawerState();
}

class _StyledDrawerState extends State<StyledDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    var mode = themeCubit.state;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final photo = user.photo;
    final name = user.firstName;

    return Drawer(
      child: Column(children: [
        Expanded(child: ListView(
        children: [
        DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.appBar,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current user's avatar
                Avatar(photo: photo ?? ''),
                const SizedBox(height: 12),
                // Current user's name
                Text(name??'', style: TextStyle(color: Colors.brown)),
                // TODO: implement get() user's following and followers
                Row(children: [
                  Text('Following: 0', style: TextStyle(color: Colors.brown)),
                  Spacer(),
                  Text('Followers: 0', style: TextStyle(color: Colors.brown))
                ],)
              ],
            ),
          ),
        ListTile(
          onTap: () { 
            Navigator.pop(context);
            Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ProfilePage(),
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
              builder: (context) => const Settings(),
            )
          );
          },
          leading: Icon(Icons.settings),
          title: Text('Settings'),
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
            StyledSwitch(
                  key: const Key('drawer_themeMode_switch'),
                  value: mode == ThemeMode.light,
                  onChanged: (value) {
                    themeCubit.toggleTheme();
                    setState(() {
                    value = !value;
                    });
                  },
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