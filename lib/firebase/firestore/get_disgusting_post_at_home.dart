import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference disgustingPosts =
    FirebaseFirestore.instance.collection('disgusting_posts');

Future<List<QueryDocumentSnapshot>> getDisgustingPostAtHome() async {
  late List<QueryDocumentSnapshot>? data;

  await disgustingPosts
      .orderBy('createdAt', descending: true)
      .get()
      .then((QuerySnapshot querySnapshot) {
    data = querySnapshot.docs;
  });

  return Future<List<QueryDocumentSnapshot>>.value(data);
}
