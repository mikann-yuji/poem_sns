import '../acitons/app_state_actions.dart';
import '../app_state.dart';

int counterReducer(AppState state, action) {
  if (action is IncrementAction) {
    final AppState newState = state.copyWith(counter: state.counter + 1);

    return newState.counter;
  } else {
    return state.counter;
  }
}
