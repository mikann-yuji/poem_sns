import '../app_state.dart';
import './counter_reducer.dart';
import './is_login_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    counter: counterReducer(state, action),
    isLogin: isLoginReducer(state, action),
  );
}
