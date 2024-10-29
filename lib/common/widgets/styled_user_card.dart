import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';

import '../../core/configs/assets/avatar.dart';

class StyledUserCard extends StatelessWidget {
  final User user;
  const StyledUserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Avatar(photo: user.photo),
                    SizedBox(width: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(user.firstName ?? ''),
                        Text(user.lastName ?? '')
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}