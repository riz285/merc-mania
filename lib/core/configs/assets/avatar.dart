import 'dart:io';

import 'package:flutter/material.dart';

import 'app_images.dart';

class Avatar extends StatelessWidget {
  final String? photo;
  final File? image;
  final double? size;
  const Avatar({super.key, this.photo, this.image, this.size});

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;
    if (photo != null && image == null) {
        return CircleAvatar(
        radius: size,
        backgroundImage: NetworkImage(photo),
        backgroundColor: Colors.white
      );
    } else if (photo == null && image != null) {
        return CircleAvatar(
        radius: size,
        backgroundImage: FileImage(image!),
        backgroundColor: Colors.white
      );
    }
    return CircleAvatar(
      radius: size,
      backgroundImage: AssetImage(AppImages.defaultPhoto),
      backgroundColor: Colors.white
    );
  }
}