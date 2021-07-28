import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

Object? getUser(String uid) async {
  late Object? data;

  await users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
    data = documentSnapshot.data();
  });

  return data;
}
