import '../acitons/app_state_actions.dart';
import '../app_state.dart';

bool isLoginReducer(AppState state, action) {
  if (action is LoginAction) {
    final AppState newState = state.copyWith(isLogin: true);

    return newState.isLogin;
  } else if (action is LogoutAction) {
    final AppState newState = state.copyWith(isLogin: false);

    return newState.isLogin;
  } else {
    return state.isLogin;
  }
}
