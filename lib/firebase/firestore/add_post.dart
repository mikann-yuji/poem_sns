import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference posts = FirebaseFirestore.instance.collection('posts');

Future<void> addPost({String? content, String? uid}) {
  return posts
      .add({
        'content': content,
        'uid': uid,
      })
      .then((value) => print("Post Added"))
      .catchError((error) => print("Failed to add post: $error"));
}
