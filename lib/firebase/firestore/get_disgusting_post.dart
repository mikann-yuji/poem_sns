import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference disgustingPosts =
    FirebaseFirestore.instance.collection('disgusting_posts');

Future<List<QueryDocumentSnapshot>> getDisgustingPost(String uid) async {
  late List<QueryDocumentSnapshot>? data;

  await disgustingPosts
      .where('uid', isEqualTo: uid)
      .get()
      .then((QuerySnapshot querySnapshot) {
    data = querySnapshot.docs;
  });

  return Future<List<QueryDocumentSnapshot>>.value(data);
}
