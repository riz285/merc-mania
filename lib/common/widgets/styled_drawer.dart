import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/core/configs/assets/avatar.dart';
import 'package:merc_mania/core/configs/themes/app_colors.dart';
import 'package:merc_mania/screens/order/view/order_page.dart';
import 'package:merc_mania/screens/settings/settings_page.dart';
import 'styled_switch.dart';

import '../../app/bloc/app_bloc.dart';
import '../../screens/theme_modes/cubit/theme_cubit.dart';
import '../../screens/profile/cubit/profile_cubit.dart';

import '../../screens/profile/view/profile_display/profile_page.dart';
import '../../screens/cart/view/cart_screen.dart';
import '../../screens/help_center/help_center.dart';
import '../../screens/policy/policy.dart';

class StyledDrawer extends StatefulWidget {
  const StyledDrawer({super.key});

  @override
  State<StyledDrawer> createState() => _StyledDrawerState();
}

class _StyledDrawerState extends State<StyledDrawer> {
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
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    final mode = themeCubit.state;

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) => setState(() {}),
      child: FutureBuilder(
        future: fetchUserData(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center();
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          final data = snapshot.data!.data()!;
          // Drawer Items
          return Drawer(
            child: Column(children: [
              Expanded(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                  // Drawer Header
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: AppColors.appBar,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Current user's avatar
                          Avatar(photo: data['photo'], size: 35),
                          const SizedBox(height: 12),
                          // Current user's name
                          Text('${data['first_name'] ?? ''}   ${data['last_name'] ?? ''}', 
                            style: TextStyle(color: Colors.brown)),
                          // TODO: implement get() user's following and followers
                          Row(children: [
                            Text('Following: 0', style: TextStyle(color: Colors.brown)),
                            Spacer(),
                            Text('Followers: 0', style: TextStyle(color: Colors.brown))
                          ],)
                        ],
                      ),
                    ),
                  ),
                  // Drawer Item List
                  ListTile( // Personal Information
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
                  ListTile( // User's Cart
                    onTap: () { 
                      Navigator.pop(context);
                      Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CartView(),
                      )
                    );
                  },
                  leading: Icon(Icons.shopping_cart),
                  title: Text('Cart'),
                  ),
                  ListTile( // User's Orders
                    onTap: () { 
                      Navigator.pop(context);
                      Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const OrderPage(),
                        ) 
                      );
                    },
                    leading: Icon(Icons.list_alt),
                    title: Text('Orders'),
                  ),
                  ListTile( // Settings
                    onTap: () { 
                      Navigator.pop(context);
                      Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage())
                      );
                    },
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  ListTile( // Help Center
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
                  ListTile( // Policy
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
                  ),
                  ]
                )
              ),
              Align(
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: StyledSwitch( // Theme Switch
                          key: const Key('drawer_themeMode_switch'),
                          value: mode == ThemeMode.light,
                          onChanged: (value) {
                            themeCubit.toggleTheme();
                            setState(() {
                            value = !value;
                            });
                          },
                        ),
                  ),
                  Spacer(),
                  IconButton( // LogOut button
                    key: const Key('drawer_logout_iconButton'),
                    onPressed: () {
                      context.read<AppBloc>().add(const AppLogoutPressed());
                    }, icon: Icon(Icons.logout))
                  ])
              )
            ])
          );
        }
      )
    );
  }
}