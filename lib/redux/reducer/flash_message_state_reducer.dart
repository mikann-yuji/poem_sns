import '../acitons/app_state_actions.dart';
import '../app_state.dart';
import '../state/flash_message_state.dart';

FlashMessageState flashMessageStateReducer(AppState state, dynamic action) {
  if (action is ChangeFlashMessageState) {
    final FlashMessageState newFlashMessageState = FlashMessageState().copyWith(
      flag: action.flag,
      content: action.content,
    );
    final AppState newState = state.copyWith(
      flashMessageState: newFlashMessageState,
    );

    return newState.flashMessageState;
  } else {
    return state.flashMessageState;
  }
}
