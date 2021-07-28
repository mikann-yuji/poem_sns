import 'package:flutter/material.dart';

import 'dart:typed_data';

class AvatarImage extends StatelessWidget {
  const AvatarImage({Key? key, required this.radius, required this.imageBytes}) : super(key: key);

  final int radius;
  final Uint8List imageBytes;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius.toDouble(),
      height: radius.toDouble(),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: MemoryImage(imageBytes),
        ),
      ),
    );
  }
}
