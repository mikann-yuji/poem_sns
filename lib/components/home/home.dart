import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../redux/acitons/app_state_actions.dart';
import '../../redux/app_state.dart';
import '../../redux/view_model.dart';
import '../shared/flash_message.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.originContext}) : super(key: key);

  final BuildContext originContext;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StoreConnector<AppState, ViewModel>(
          converter: (store) => ViewModel.fromStore(store),
          builder: (context, viewModel) {
            return Text(
              'redux で増える: ${viewModel.counter.toString()} ${viewModel.isLogin.toString()} ${viewModel.currentUser.username}',
            );
          },
        ),
        StoreConnector<AppState, ViewModel>(
          converter: (store) => ViewModel.fromStore(store),
          builder: (context, viewModel) {
            return ElevatedButton(
              child: Text(
                'reduxで数字をふやす',
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
              ),
              onPressed: () => viewModel.dispatch(new IncrementAction()),
            );
          },
        ),
        FlashMessage(originContext: widget.originContext),
      ],
    ));
  }
}
