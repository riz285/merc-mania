import 'package:flutter/material.dart';

import 'app_images.dart';

class Avatar extends StatelessWidget {
  final String? photo;
  final double? size;
  const Avatar({super.key, this.photo, this.size});

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;
    if (photo != null) {
        return CircleAvatar(
        radius: size,
        backgroundImage: NetworkImage(photo),
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