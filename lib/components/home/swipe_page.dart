import 'package:flutter/material.dart';

import './home.dart';
import './ranking.dart';
import './category.dart';

class SwipePage extends StatefulWidget {
  const SwipePage(
      {Key? key,
      required this.originContext,
      required this.pageController})
      : super(key: key);

  final BuildContext originContext;
  final PageController pageController;

  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  // final PageController controller = PageController(
  //   initialPage: 1,
  // );

  // void test() {
  //   controller.jumpToPage(2);
  // }

  @override
  Widget build(BuildContext context) {
    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      scrollDirection: Axis.horizontal,
      controller: widget.pageController,
      children: [
        Ranking(
          originContext: widget.originContext,
        ),
        Home(
          originContext: widget.originContext,
        ),
        Category(
          originContext: widget.originContext,
        ),
      ],
    );
  }
}
