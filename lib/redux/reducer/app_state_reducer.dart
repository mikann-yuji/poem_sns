import '../app_state.dart';
import './counter_reducer.dart';
import './is_login_reducer.dart';
import './current_user_reducer.dart';
import './post_content_reducer.dart';
import './flash_message_state_reducer.dart';
import './swipe_page_index_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    counter: counterReducer(state, action),
    isLogin: isLoginReducer(state, action),
    currentUser: currentUserReducer(state, action),
    postContent: postContentReducer(state, action),
    flashMessageState: flashMessageStateReducer(state, action),
    swipePageIndex: swipePageIndexReducer(state, action),
  );
}
