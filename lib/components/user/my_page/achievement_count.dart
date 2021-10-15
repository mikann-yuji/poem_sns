import 'package:flutter/material.dart';

class AchievementCount extends StatelessWidget {
  const AchievementCount({Key? key, required this.title, required this.count, required this.transitionPageFunction})
      : super(key: key);

  final String title;
  final int count;
  final void Function() transitionPageFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => transitionPageFunction(),
        child: Column(
          children: [
            Text(
              '${this.count}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text(
              this.title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
