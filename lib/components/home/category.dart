import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../redux/acitons/app_state_actions.dart';
import '../../redux/app_state.dart';
import '../../redux/view_model.dart';
import '../shared/flash_message.dart';

class Category extends StatefulWidget {
  const Category({Key? key, required this.originContext}) : super(key: key);

  final BuildContext originContext;

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('たしかめ'),
          Text('難しい'),
          FlashMessage(originContext: widget.originContext),
        ],
    ));
  }
}
