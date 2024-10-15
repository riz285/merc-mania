import 'package:flutter/material.dart';

const _avatarSize = 35.0;

class Avatar extends StatelessWidget {
  final String photo;
  const Avatar({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;
    return CircleAvatar(
      radius: _avatarSize,
      backgroundImage: NetworkImage(photo),
      backgroundColor: Colors.grey,
      child: photo == ''
          ? const Icon(Icons.person_outline, size: _avatarSize)
          : null,
    );
  }
}