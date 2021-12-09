import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference disgusPostsHashtagsRelation =
    FirebaseFirestore.instance.collection('disgus_posts_hashtags_relation');

Future<void> addDisgusPostHashtagRelation({required String disgusPostId, required String hashtagId}) {
  DateTime createdAt = DateTime.now();
  Timestamp createdAtTimestamp = Timestamp.fromDate(createdAt);

  return disgusPostsHashtagsRelation
      .add({
        'disgusPostsId': disgusPostId,
        'hashtagId': hashtagId,
        'createdAt': createdAtTimestamp,
      })
      .then((value) => print('test'))
      .catchError((error) => print("Failed to add post: $error"));
}
