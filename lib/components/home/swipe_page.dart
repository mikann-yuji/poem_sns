import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import './home.dart';
import './ranking.dart';
import './category.dart';
import '../../redux/acitons/app_state_actions.dart';
import '../../redux/app_state.dart';
import '../../redux/view_model.dart';

class SwipePage extends StatefulWidget {
  const SwipePage(
      {Key? key, required this.originContext, required this.pageController})
      : super(key: key);

  final BuildContext originContext;
  final PageController pageController;

  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        converter: (store) => ViewModel.fromStore(store),
        builder: (context, viewModel) {
          return PageView(
            scrollDirection: Axis.horizontal,
            controller: widget.pageController,
            onPageChanged: (int index) {
              viewModel.dispatch(new ChangeSwipePageIndexAction(index: index));
            },
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
        });
  }
}
