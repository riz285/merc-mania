import 'package:flutter/material.dart';
import 'package:merc_mania/common/widgets/styled_navigation_bar.dart';
import 'package:merc_mania/home/view/home_page.dart';
import 'package:merc_mania/screens/chat/view/chat_page.dart';

import '../../screens/notifications/view/notification_screen.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomeView());

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController pageController = PageController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  static final List<Widget> pages = <Widget>[
    const HomePage(),
    const NotificationScreen(),
    const ChatPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
        controller: pageController,
        children: pages,
      ),
      bottomNavigationBar: StyledNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: (page) {
          pageController.animateToPage(page, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
        },
      ),
      //HomeView()
    );
  }
}