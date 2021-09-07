import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future<String> getAvatarImage(String uid) async {
  String downloadURL = await firebase_storage.FirebaseStorage.instance
      .ref('user/$uid/avatar.jpeg')
      .getDownloadURL();

  return Future<String>.value(downloadURL);
}
