import 'package:redux/redux.dart';

import './app_state.dart';
import './state/current_user.dart';
import './state/post_content.dart';
import './state/flash_message_state.dart';

class ViewModel {
  final int counter;
  final bool isLogin;
  final CurrentUser currentUser;
  final PostContent postContent;
  final FlashMessageState flashMessageState;
  final Store<AppState> store;

  ViewModel({
    required this.counter,
    required this.isLogin,
    required this.currentUser,
    required this.postContent,
    required this.flashMessageState,
    required this.store,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      counter: store.state.counter,
      isLogin: store.state.isLogin,
      currentUser: store.state.currentUser,
      postContent: store.state.postContent,
      flashMessageState: store.state.flashMessageState,
      store: store,
    );
  }

  void dispatch(dynamic action) {
    store.dispatch(action);
  }
}
