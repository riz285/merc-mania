import 'package:flutter/material.dart';

import '../../common/widgets/styled_app_bar.dart';
import 'settings_screen.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SettingsScreen())
    );
  }
}