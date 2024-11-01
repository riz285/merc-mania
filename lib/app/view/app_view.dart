import 'package:flutter/material.dart';
import 'package:merc_mania/common/widgets/styled_navigation_bar.dart';
import 'package:merc_mania/screens/home/view/home_page.dart';
import 'package:merc_mania/screens/chat/view/chat_page.dart';

import '../../screens/notifications/view/notification_screen.dart';


class AppView extends StatefulWidget {
  const AppView({super.key});

  static Page<void> page() => const MaterialPage<void>(child: AppView());

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
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
    );
  }
}