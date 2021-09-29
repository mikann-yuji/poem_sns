class IncrementAction {}

class LoginAction {}

class LogoutAction {}

class RemoveCurrentUserAction {}

class AddCurrentUserAction {
  final String username;
  final String uid;
  final String email;
  final String imageURL;

  AddCurrentUserAction({
    this.username = '',
    this.uid = '',
    this.email = '',
    this.imageURL = '',
  });
}

class ChangePostContentAction {
  final String content;

  ChangePostContentAction({
    this.content = '',
  });
}

class ChangeFlashMessageState {
  final bool flag;
  final String content;

  ChangeFlashMessageState({
    this.flag = false,
    this.content = '',
  });
}

class ChangeSwipePageIndexAction {
  final int index;

  ChangeSwipePageIndexAction({
    this.index = 1,
  });
}
