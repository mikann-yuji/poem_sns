import './state/current_user.dart';
import './state/post_content.dart';
import './state/flash_message_state.dart';
import './state/swipe_page_index.dart';

class AppState {
  late bool isLoading;
  late int counter;
  late bool isLogin;
  late CurrentUser currentUser;
  late PostContent postContent;
  late FlashMessageState flashMessageState;
  late SwipePageIndex swipePageIndex;

  AppState({
    this.isLoading = false,
    this.counter = 0,
    this.isLogin = false,
    this.currentUser = const CurrentUser(),
    this.postContent = const PostContent(),
    this.flashMessageState = const FlashMessageState(),
    this.swipePageIndex = const SwipePageIndex(),
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
    SwipePageIndex? swipePageIndex,
  }) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      counter: counter ?? this.counter,
      isLogin: isLogin ?? this.isLogin,
      currentUser: currentUser ?? this.currentUser,
      postContent: postContent ?? this.postContent,
      flashMessageState: flashMessageState ?? this.flashMessageState,
      swipePageIndex: swipePageIndex ?? this.swipePageIndex,
    );
  }
}
