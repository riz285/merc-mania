import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/home/view/home_screen.dart';

import '../../common/widgets/navigation_bar/cubit/navigation_bar_cubit.dart';
import '../../notifications/view/notification_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  static final List<Widget> pages = <Widget>[
    const HomeScreen(),
    const NotificationScreen(),
    //
  ];
  
  void onPageChanged(int index) {
    context.read<StyledNavigationBarCubit>().navigateToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      onPageChanged: (int page) => onPageChanged(page),
      controller: pageController,
      children: pages,
    );
  }
}