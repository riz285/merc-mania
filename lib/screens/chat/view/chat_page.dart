import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/common/widgets/styled_drawer.dart';

import '../../../common/widgets/chat_search.dart';
import '../cubit/chat_cubit.dart';
import 'chat_screen.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: const Text('Chat'),
          leading: Builder(builder: (BuildContext context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            }, 
            icon: Icon(Icons.menu),
          )),
          actions: <Widget>[
            IconButton(
              key: const Key('homePage_search_iconButton'),
              icon: const Icon(Icons.search),
              onPressed: () { showSearch(context: context, delegate: ChatSearchDelegate()); },
            ),
          ],
        ),
      drawer: StyledDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<ChatCubit>(
          create: (_) => ChatCubit(context.read<AuthenticationRepository>()),
          child: const ChatScreen(),
        ),
      ),
    );
  }
}