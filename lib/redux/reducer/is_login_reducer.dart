import '../acitons/app_state_actions.dart';
import '../app_state.dart';

bool isLoginReducer(AppState state, AppStateActions action) {
  switch (action) {
    case AppStateActions.Login:
      final AppState newState = state.copyWith(isLogin: true);

      return newState.isLogin;
    case AppStateActions.Logout:
      final AppState newState = state.copyWith(isLogin: false);

      return newState.isLogin;
    default:
      return state.isLogin;
  }
}
