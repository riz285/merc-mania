import 'package:flutter/material.dart';

import '../../../common/widgets/styled_drawer.dart';
import '../../../core/configs/themes/app_colors.dart';
import 'home_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown)),
          backgroundColor: AppColors.appBar,
          leading: Builder(builder: (BuildContext context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            }, 
            icon: Icon(Icons.menu,
              size: 25,
              color: AppColors.title))),
          actions: <Widget>[
            IconButton(
              key: const Key('homePage_search_iconButton'),
              icon: const Icon(Icons.search,
              size: 25,
              color: AppColors.title),
              onPressed: () {},
            ),
          ],
        ),
        drawer: StyledDrawer(),
        body: const HomeScreen(),
    );
  }
}