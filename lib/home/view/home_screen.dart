import 'package:flutter/material.dart';

import '../../core/configs/themes/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: const Alignment(-1.0,-1.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Popular',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold
              )),
            ),
            // CustomScrollView()
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Recently Searched',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold
              )),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Recommended',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold
              )),
            ),
          ],
        ),
      );
  }
}