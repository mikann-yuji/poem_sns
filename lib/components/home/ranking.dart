import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../redux/acitons/app_state_actions.dart';
import '../../redux/app_state.dart';
import '../../redux/view_model.dart';
import '../shared/flash_message.dart';

class Ranking extends StatefulWidget {
  const Ranking({Key? key, required this.originContext}) : super(key: key);

  final BuildContext originContext;

  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'You have pushed the button this many times:',
        ),
        Text('説明しよう！！！！'),
        FlashMessage(originContext: widget.originContext),
      ],
    ));
  }
}
