import '../acitons/app_state_actions.dart';
import '../app_state.dart';

int counterReducer(AppState state, AppStateActions action) {
  switch (action) {
    case AppStateActions.Increment:
      final AppState newState = state.copyWith(counter: state.counter + 1);

      return newState.counter;
    default:
      return state.counter;
  }
}
