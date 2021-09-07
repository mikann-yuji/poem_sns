import './state/current_user.dart';
import './state/post_content.dart';

class AppState {
  late bool isLoading;
  late int counter;
  late bool isLogin;
  late CurrentUser currentUser;
  late PostContent postContent;

  AppState({
    this.isLoading = false,
    this.counter = 0,
    this.isLogin = false,
    this.currentUser = const CurrentUser(),
    this.postContent = const PostContent(),
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
  }) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      counter: counter ?? this.counter,
      isLogin: isLogin ?? this.isLogin,
      currentUser: currentUser ?? this.currentUser,
      postContent: postContent ?? this.postContent,
    );
  }
}
