import './state/current_user.dart';
import './state/post_content.dart';
import './state/flash_message_state.dart';

class AppState {
  late bool isLoading;
  late int counter;
  late bool isLogin;
  late CurrentUser currentUser;
  late PostContent postContent;
  late FlashMessageState flashMessageState;

  AppState({
    this.isLoading = false,
    this.counter = 0,
    this.isLogin = false,
    this.currentUser = const CurrentUser(),
    this.postContent = const PostContent(),
    this.flashMessageState = const FlashMessageState(),
  });

  factory AppState.loading() => AppState(
        isLoading: true,
      );

  AppState copyWith({
    bool? isLoading,
    int? counter,
    bool? isLogin,
    CurrentUser? currentUser,
    PostContent? postContent,
    FlashMessageState? flashMessageState,
  }) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      counter: counter ?? this.counter,
      isLogin: isLogin ?? this.isLogin,
      currentUser: currentUser ?? this.currentUser,
      postContent: postContent ?? this.postContent,
      flashMessageState: flashMessageState ?? this.flashMessageState,
    );
  }
}
