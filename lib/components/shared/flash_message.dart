import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../redux/acitons/app_state_actions.dart';
import '../../redux/app_state.dart';
import '../../redux/view_model.dart';

class FlashMessage extends StatelessWidget {
  const FlashMessage({Key? key, required BuildContext originContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        converter: (store) => ViewModel.fromStore(store),
        onDidChange: (prev, next) {
          if (next.flashMessageState.flag) {
            final snackBar =
                SnackBar(content: Text(next.flashMessageState.content));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (originContext, viewModel) {
          if (viewModel.flashMessageState.flag) {
            viewModel.dispatch(
                new ChangeFlashMessageState(flag: false, content: ''));
            return Container();
          } else {
            return Container();
          }
        });
  }
}
