import '../acitons/app_state_actions.dart';
import '../app_state.dart';
import '../state/current_user.dart';

CurrentUser currentUserReducer(AppState state, dynamic action) {
  if (action is AddCurrentUserAction) {
    final CurrentUser newCurrentUser = CurrentUser().copyWith(
        username: action.username, uid: action.uid, email: action.email, imageURL: action.imageURL);
    final AppState newState = state.copyWith(
      currentUser: newCurrentUser,
    );

    return newState.currentUser;
  } else if (action is RemoveCurrentUserAction) {
    final CurrentUser newCurrentUser =
        CurrentUser().copyWith(username: '', uid: '', email: '', imageURL: '');
    final AppState newState = state.copyWith(
      currentUser: newCurrentUser,
    );

    return newState.currentUser;
  } else {
    return state.currentUser;
  }
}
