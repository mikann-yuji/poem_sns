import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../home/home.dart';
import '../register/register.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // int _counter = 0;
  bool _isNotCorrectPassword = false;
  String _emailText = '';
  String _passwordText = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void _transition() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }

  void _signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailText, password: _passwordText);

      print(userCredential.user!.uid);

      setState(() {
        _isNotCorrectPassword = false;
      });

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MyHomePage(title: 'Flutter Demo Test Home Page'),
        ),
      );

      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // final user = users.doc(userCredential.uid).get();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        setState(() {
          _isNotCorrectPassword = true;
        });
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        setState(() {
          _isNotCorrectPassword = true;
        });
      }
    }
  }

  void _googleTransition() {
    signInWithGoogle().then((UserCredential user) => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MyHomePage(title: 'Flutter Demo Test Home Page'),
            ),
          )
        });
  }

  void _handleEmailText(String e) {
    setState(() {
      _emailText = e;
    });
  }

  void _handlePasswordText(String e) {
    setState(() {
      _passwordText = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextFormField(
                  enabled: true,
                  onChanged: _handleEmailText,
                  decoration: InputDecoration(
                    hintText: 'メールアドレス',
                  )),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextFormField(
                  enabled: true,
                  onChanged: _handlePasswordText,
                  decoration: InputDecoration(
                    hintText: 'パスワード',
                  )),
            ),
            Visibility(
              visible: _isNotCorrectPassword,
              child: Text(
                'パスワードが違います',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            ElevatedButton(
              child: Text(widget.title),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
              ),
              onPressed: _signIn,
            ),
            ElevatedButton(
              child: Text('Googleでログインする'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
              ),
              onPressed: _googleTransition,
            ),
            ElevatedButton(
              child: Text('新規登録する'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
              ),
              onPressed: _transition,
            ),
          ],
        ),
      ),
    );
  }
}
