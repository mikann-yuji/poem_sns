import '../acitons/app_state_actions.dart';
import '../app_state.dart';
import '../state/swipe_page_index.dart';

SwipePageIndex postContentReducer(AppState state, dynamic action) {
  if (action is ChangeSwipePageIndexAction) {
    final SwipePageIndex newSwipePageIndex = SwipePageIndex().copyWith(
      content: action.content,
    );
    final AppState newState = state.copyWith(
      postContent: newSwipePageIndex,
    );

    return newState.postContent;
  } else {
    return state.postContent;
  }
}
