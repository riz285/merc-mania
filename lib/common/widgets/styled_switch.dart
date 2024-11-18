import 'package:flutter/material.dart';
import 'package:merc_mania/core/configs/themes/app_colors.dart';

import '../../core/configs/assets/app_icons.dart';


class StyledSwitch extends StatelessWidget {
  const StyledSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value, 
      onChanged: onChanged,
      activeTrackColor: AppColors.title,
      activeThumbImage: AssetImage(AppIcons.lightMode),
      inactiveTrackColor: const Color.fromARGB(255, 96, 79, 102),
      inactiveThumbImage: AssetImage(AppIcons.darkMode),
    );
  }
}