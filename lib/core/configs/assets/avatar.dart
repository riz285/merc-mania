import 'dart:io';

import 'package:flutter/material.dart';

import 'app_images.dart';

const _avatarSize = 35.0;

class Avatar extends StatelessWidget {
  final String? photo;
  final File? image;
  const Avatar({super.key, this.photo, this.image});

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;
    if (photo != null && image == null) {
        return CircleAvatar(
        radius: _avatarSize,
        backgroundImage: NetworkImage(photo),
        backgroundColor: Colors.white
      );
    } else if (photo == null && image != null) {
        return CircleAvatar(
        radius: _avatarSize,
        backgroundImage: FileImage(image!),
        backgroundColor: Colors.white
      );
    }
    return CircleAvatar(
      radius: _avatarSize,
      backgroundImage: NetworkImage(AppImages.defaultPhoto),
      backgroundColor: Colors.white
    );
  }
}