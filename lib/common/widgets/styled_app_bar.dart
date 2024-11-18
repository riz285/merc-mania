import 'package:flutter/material.dart';

import '../../core/configs/themes/app_colors.dart';

class StyledAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget> ? actions;
  const StyledAppBar({this.title, super.key, this.actions, this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      title: title ?? const Text(''),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.title,
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
      leading: leading ?? IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.navigate_before,
            size: 25,
            color: AppColors.title
          ),
      ),
      actions: actions,
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(50);
}
