import 'package:cloud_firestore/cloud_firestore.dart';

import '../../locale/intl_time.dart';

CollectionReference posts =
    FirebaseFirestore.instance.collection('disgusting_posts');

Future<void> addDisgustingPost({String? content, String? uid}) {
  String now = IntlTime().getNow();

  return posts
      .add({
        'content': content,
        'uid': uid,
        'now': now,
      })
      .then((value) => print("Post Added"))
      .catchError((error) => print("Failed to add post: $error"));
}
