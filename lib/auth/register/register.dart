import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as imgLib;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'dart:io';
import 'dart:typed_data';

import '../../home/home.dart';
import '../../firestore/add_user.dart';
import '../../user/avatar_image.dart';
import '../../redux/acitons/app_state_actions.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String _username;
  late String _email;
  late String _password;
  late Uint8List _imageBytes;
  late File _imageFile;
  bool _isImage = false;
  final int _radius = 200;

  final _form = GlobalKey<FormState>();

  void _userRegister() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);

      await addUser(
          username: _username,
          email: _email.toLowerCase(),
          uid: userCredential.user!.uid);

      final path = 'user/${userCredential.user!.uid}/avatar.jpeg';
      FirebaseStorage storage = FirebaseStorage.instance;
      await storage.ref().child(path).putFile(_imageFile);

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MyHomePage(title: 'Flutter Demo Test Home Page'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void _avatarPicker() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    _imageFile = File(pickedFile!.path);
    imgLib.Image? image = imgLib.decodeImage(_imageFile.readAsBytesSync());

    if (image != null) {
      imgLib.Image resizedImage = imgLib.copyResizeCropSquare(image, _radius);

      setState(() {
        _imageBytes = Uint8List.fromList(imgLib.encodeJpg(resizedImage));
        _isImage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Form(
      key: _form,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: _avatarPicker, child: Text('ユーザー画像を選ぶ')),
          _isImage
              ? AvatarImage(radius: _radius, imageBytes: _imageBytes)
              : Text('画像が選ばれていません'),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'ユーザーネーム',
            ),
            textInputAction: TextInputAction.next,
            onSaved: (value) {
              _username = value ?? '';
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'メールアドレス',
            ),
            textInputAction: TextInputAction.next,
            onSaved: (value) {
              _email = value ?? '';
            },
          ),
          TextFormField(
              decoration: InputDecoration(
                labelText: 'パスワード',
              ),
              obscureText: true,
              onSaved: (value) {
                _password = value ?? '';
              }),
          // StoreConnector(
          //   converter: (store) {
          //     return () => store.dispatch(App)
          //   },
          // )
          ElevatedButton(
            child: Text('登録する'),
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              onPrimary: Colors.white,
            ),
            onPressed: () {
              _form.currentState!.save();
              _userRegister();
            },
          ),
          ElevatedButton(
            child: Text('戻る'),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    )));
  }
}
