import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/assets/avatar.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Row(children: [
            Avatar(photo: user.photo),
            SizedBox(width: 8),
            Text('${user.firstName ?? ''} ${user.lastName ?? ''}'),
          ],),
        ),
        onTap: () {},
      ),
    );
  }
}