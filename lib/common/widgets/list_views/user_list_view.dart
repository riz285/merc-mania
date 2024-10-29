import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:merc_mania/common/widgets/styled_user_card.dart';

class UserListView extends StatelessWidget {
  final List<User> users;
  final User currentUser;
  const UserListView({super.key, required this.users, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
            itemCount: users.length,
            itemBuilder: (context, index) {
              if (currentUser.email != users[index].email) {
                return StyledUserCard(user: users[index]);
              }
              return null;
              }, 
            separatorBuilder: (context, index) => SizedBox(width: 5),
    );
  }
}