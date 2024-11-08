import 'package:flutter/material.dart';

import '../../../common/widgets/styled_drawer.dart';
import 'home_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Home'),
          leading: Builder(builder: (BuildContext context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            }, 
            icon: Icon(Icons.menu)
          )),
          actions: <Widget>[
            IconButton(
              key: const Key('homePage_search_iconButton'),
              icon: const Icon(Icons.search),
              onPressed: () {}, //TODO: implement product search
            ),
          ],
        ),
        drawer: StyledDrawer(),
        body: const HomeScreen(),
    );
  }
}