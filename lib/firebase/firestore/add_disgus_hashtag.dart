import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference hashtags =
    FirebaseFirestore.instance.collection('disgus_hashtags');

Future<void> addDisgusHashtag({String? hashtag, String? uid, bool? isOrigin}) {
  DateTime createdAt = DateTime.now();
  Timestamp createdAtTimestamp = Timestamp.fromDate(createdAt);

  return hashtags
      .add({
        'hashtag': hashtag,
        'origin': isOrigin ?? false,
        'createdAt': createdAtTimestamp,
      })
      .then((value) => print("Post Added"))
      .catchError((error) => print("Failed to add post: $error"));
}
