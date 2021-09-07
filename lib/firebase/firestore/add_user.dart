import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> addUser({String? username, String? email, String? uid}) {
  return users
      .add({
        'username': username,
        'email': email,
        'uid': uid,
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
