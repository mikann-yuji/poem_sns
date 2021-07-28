import './state/current_user.dart';

class AppState {
  late bool isLoading;
  late int counter;
  late bool isLogin;
  late CurrentUser currentUser;

  AppState({
    this.isLoading = false,
    this.counter = 0,
    this.isLogin = false,
    this.currentUser = const CurrentUser(),
  });

  factory AppState.loading() => AppState(
    isLoading: true,
  );

  AppState copyWith({
    bool? isLoading,
    int? counter,
    bool? isLogin,
    CurrentUser? currentUser,
  }) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      counter: counter ?? this.counter,
      isLogin: isLogin ?? this.isLogin,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
