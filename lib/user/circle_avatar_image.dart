import 'package:flutter/material.dart';

class CircleAvatarImage extends StatelessWidget {
  const CircleAvatarImage({Key? key, required this.radius, required this.imageURL}) : super(key: key);

  final int radius;
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius.toDouble(),
      height: radius.toDouble(),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(imageURL),
        ),
      ),
    );
  }
}
