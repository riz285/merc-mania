import 'package:flutter/material.dart';
import 'package:merc_mania/home/view/home_screen.dart';

import '../../../core/configs/themes/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),),
          backgroundColor: AppColors.appBar,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),);
            }, 
            icon: Icon(Icons.navigate_before)),
      )
    );
  }
}