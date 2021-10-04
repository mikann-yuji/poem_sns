import '../acitons/app_state_actions.dart';
import '../app_state.dart';
import '../state/swipe_page_index.dart';

SwipePageIndex swipePageIndexReducer(AppState state, dynamic action) {
  if (action is ChangeSwipePageIndexAction) {
    final SwipePageIndex newSwipePageIndex = SwipePageIndex().copyWith(
      index: action.index,
    );
    final AppState newState = state.copyWith(
      swipePageIndex: newSwipePageIndex,
    );

    return newState.swipePageIndex;
  } else {
    return state.swipePageIndex;
  }
}
