import 'package:flutter/material.dart';
import 'package:merc_mania/core/configs/themes/app_colors.dart';

class StyledNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  const StyledNavigationBar({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        indicatorColor: AppColors.primary,
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) { 
          onTap(index);
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.notifications),
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.notifications_outlined)),
            label: 'Notifications',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.chat),
            icon: Badge(
              label: Text('3'),
              child: Icon(Icons.chat_bubble_outline),
            ),
            label: 'Inbox',
          ),
        ],
      );
    // 
  }
}