import '../acitons/app_state_actions.dart';
import '../app_state.dart';
import '../state/post_content.dart';

PostContent postContentReducer(AppState state, dynamic action) {
  if (action is ChangePostContentAction) {
    final PostContent newPostContent = PostContent().copyWith(
      content: action.content,
    );
    final AppState newState = state.copyWith(
      postContent: newPostContent,
    );

    return newState.postContent;
  } else {
    return state.postContent;
  }
}
