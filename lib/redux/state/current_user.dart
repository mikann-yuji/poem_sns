import 'package:meta/meta.dart';

@immutable
class CurrentUser {
  final String username;
  final String uid;
  final String email;
  final String imageURL;

  const CurrentUser({
    this.username = '',
    this.uid = '',
    this.email = '',
    this.imageURL = '',
  });

  CurrentUser copyWith({
    String? username,
    String? uid,
    String? email,
    String? imageURL,
  }) {
    return new CurrentUser(
      username: username ?? this.username,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      imageURL: imageURL ?? this.imageURL,
    );
  }
}
