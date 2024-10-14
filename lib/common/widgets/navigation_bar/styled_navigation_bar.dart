import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/core/configs/themes/app_colors.dart';

import 'cubit/navigation_bar_cubit.dart';

class StyledNavigationBar extends StatefulWidget {
  const StyledNavigationBar({super.key});

  @override
  State<StyledNavigationBar> createState() => _StyledNavigationBarState();
}

class _StyledNavigationBarState extends State<StyledNavigationBar> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StyledNavigationBarCubit, int>(builder: (context, state) {
      return NavigationBar(
        indicatorColor: AppColors.appBar,
        selectedIndex: state,
        onDestinationSelected: (index) { 
          context.read<StyledNavigationBarCubit>().navigateToPage(index);
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
              label: Text('99+'),
              child: Icon(Icons.notifications_outlined)),
            label: 'Notifications',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.inbox),
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.inbox_outlined),
            ),
            label: 'Inbox',
          ),
        ],
      );
    },);
    // 
  }
}