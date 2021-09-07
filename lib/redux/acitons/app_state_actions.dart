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
