import 'package:flutter/material.dart';

class StyledAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget ? title;
  const StyledAppBar({this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: title ?? const Text(''),
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
            child: Row(
              children: [
                const Icon(Icons.navigate_before,
                size: 15,
                ),
              ],
            ),
          )),
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
