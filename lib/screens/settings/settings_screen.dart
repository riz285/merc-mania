import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/screens/payment/view/credit_card_screen.dart';
import 'package:merc_mania/screens/security/security.dart';

import '../../common/widgets/styled_switch.dart';
import '../address/view/address_display/address_page.dart';
import '../theme_modes/cubit/theme_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}
  String dropdownValue = 'English';
  
class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    final mode = themeCubit.state;

    return ListView(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      children: [
        Column(children: [
          Text('Account Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ListTile(
            title: Text('Security'),
            onTap: () { 
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Security()));
            }),
          ListTile(
            title: Text('Address'),
            onTap: () { 
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddressPage()));
              }
            )
        ]),
        Divider(),
        Column(children: [
          Text('Manage Finances', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ListTile(
            title: Text('Credit Card'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CreditCardScreen()));
              }),
          ListTile(
            title: Text('PayPal'),
            onTap: () { 
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => AddressPage()));
              }
            )
        ]),
        Divider(),
        Column(children: [
          Text('Other Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ListTile(
            title: Text('Chat Settings'),
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => CreditCardScreen()));
              }),
          ListTile(
            title: Text('Notification Settings'),
            onTap: () { 
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => AddressPage()));
              }
            ),
          ListTile(
            title: Text('Display Mode'),
            trailing: StyledSwitch( // Theme Switch
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
          ListTile(
            title: Text('Language'),
            trailing: DropdownButton<String>(
              value: dropdownValue,
              items: <String>['English', 'Vietnamese', 'Chinese'].map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(), 
              onChanged: (newValue) {
                setState(() {
                  dropdownValue = newValue ?? 'English';
                });
              }),
          ),
        ]),
      ],
    );
  }
}