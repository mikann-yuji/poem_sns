import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<QueryDocumentSnapshot> getUser(String uid) async {
  late QueryDocumentSnapshot? data;

  await users.where('uid', isEqualTo: uid).get().then((QuerySnapshot querySnapshot) {
    data = querySnapshot.docs[0];
  });

  return Future<QueryDocumentSnapshot>.value(data);
}
