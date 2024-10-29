import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/screens/product_display/cubit/product_cubit.dart';

import '../../common/widgets/styled_drawer.dart';
import '../../core/configs/themes/app_colors.dart';
import 'home_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

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
              onPressed: () {},
                ),
              ],
            ),
        drawer: StyledDrawer(),
        body: const HomeScreen(),
    );
  }
}