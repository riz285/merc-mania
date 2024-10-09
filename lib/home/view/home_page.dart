import 'package:flutter/material.dart';
import 'package:merc_mania/common/widgets/navigation_bar/styled_navigation_bar.dart';
import 'package:merc_mania/common/widgets/styled_drawer.dart';
import 'package:merc_mania/core/configs/themes/app_colors.dart';

import '../domain/home_view.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    //final textTheme = Theme.of(context).textTheme;
    //final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold),),
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
      bottomNavigationBar: StyledNavigationBar(),
      body: HomeView() 
      //HomeView()
    );
  }
}