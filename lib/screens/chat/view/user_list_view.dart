import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merc_mania/screens/chat/view/user_card.dart';

import '../../../app/bloc/app_bloc.dart';

class UserListView extends StatelessWidget {
  final List<User> users;
  const UserListView({super.key, required this.users,});

  @override
  Widget build(BuildContext context) {
    final email = context.select((AppBloc bloc) => bloc.state.user.email);
    return ListView.separated(
            itemCount: users.length,
            itemBuilder: (context, index) {
              if (email != users[index].email) {
                return UserCard(user: users[index]);
              }
              return Container();
            }, 
            separatorBuilder: (context, index) => SizedBox(width: 5),
    );
  }
}