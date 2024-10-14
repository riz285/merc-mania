import 'package:flutter/material.dart';


class StyledSwitch extends StatelessWidget {
  const StyledSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value, 
      onChanged: onChanged,
      activeTrackColor: Colors.pinkAccent,
      //activeThumbImage: AssetImage(AppIcons.lightMode),
      inactiveTrackColor: Colors.grey[800],
      //inactiveThumbImage: AssetImage(AppIcons.darkMode),
    );
  }
}