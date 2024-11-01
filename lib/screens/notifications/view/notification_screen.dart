import 'package:flutter/material.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/common/widgets/styled_drawer.dart';

import '../../../core/configs/themes/app_colors.dart';
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: const Text('Notfications', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown)),
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
    );
  }
}