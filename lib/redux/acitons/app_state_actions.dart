enum AppStateActions {
  Increment,
  Login,
  Logout,
  RemoveCurrentUser,
}

class AddCurrentUser {
  final String username;
  final String uid;
  final String email;

  const AddCurrentUser({
    this.username = '',
    this.uid = '',
    this.email = '',
  });
}
