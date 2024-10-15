import 'package:flutter/material.dart';
import 'package:merc_mania/common/widgets/styled_navigation_bar.dart';
import 'package:merc_mania/common/widgets/styled_drawer.dart';
import 'package:merc_mania/core/configs/themes/app_colors.dart';

import '../screens/chat/view/chat_screen.dart';
import '../screens/notifications/view/notification_screen.dart';
import 'home_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  static final List<Widget> pages = <Widget>[
    const HomeScreen(),
    const NotificationScreen(),
    const ChatScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),),
        backgroundColor: AppColors.appBar,
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_search_iconButton'),
            icon: const Icon(Icons.search),
            onPressed: () {
              
            },
          ),
        ],
      ),
      drawer: StyledDrawer(),
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