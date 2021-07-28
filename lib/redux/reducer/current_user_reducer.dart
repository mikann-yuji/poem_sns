import '../acitons/app_state_actions.dart';
import '../app_state.dart';
import '../state/current_user.dart';

CurrentUser currentUserReducer(AppState state, action) {
  switch (action) {
    case AddCurrentUser:
      final CurrentUser newCurrentUser = CurrentUser().copyWith(username: action.username, uid: action.uid, email: action.email);
      final AppState newState = state.copyWith(
        currentUser: newCurrentUser,
      );

      return newState.currentUser;
    case AppStateActions.RemoveCurrentUser:
      final CurrentUser newCurrentUser = CurrentUser().copyWith(username: '', uid: '', email: '');
      final AppState newState = state.copyWith(
        currentUser: newCurrentUser,
      );

      return newState.currentUser;
    default:
      return state.currentUser;
  }
}
