import 'package:flutter/material.dart';
import 'package:merc_mania/common/widgets/styled_drawer.dart';
import 'package:merc_mania/core/configs/themes/app_colors.dart';


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
      body: Align(
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
      ),
    );
  }
}