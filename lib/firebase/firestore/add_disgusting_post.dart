import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference posts =
    FirebaseFirestore.instance.collection('disgusting_posts');

Future<void> addDisgustingPost({String? content, String? uid}) {
  DateTime createdAt = DateTime.now();
  Timestamp createdAtTimestamp = Timestamp.fromDate(createdAt);

  return posts
      .add({
        'content': content,
        'uid': uid,
        'createdAt': createdAtTimestamp,
      })
      .then((value) => print(value.id))
      // .then((value) => value.get(GetOptions()).then((value) => print(value.data())))
      .catchError((error) => print("Failed to add post: $error"));
}
