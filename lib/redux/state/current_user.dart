import 'package:meta/meta.dart';

@immutable
class CurrentUser {
  final String username;
  final String uid;
  final String email;

  const CurrentUser({
    this.username = '',
    this.uid = '',
    this.email = '',
  });

  CurrentUser copyWith({
    String? username,
    String? uid,
    String? email,
  }) {
    return new CurrentUser(
      username: username ?? this.username,
      uid: uid ?? this.uid,
      email: email ?? this.email,
    );
  }
}
