import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../home/home_page.dart';
import '../register/register.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);

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
  final _formKey = GlobalKey<FormState>();

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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailText, password: _passwordText
      );

      setState(() {
        _isNotCorrectPassword = false;
      });

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HomePage(title: 'Flutter Demo Test Home Page'),
        ),
      );

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
                  HomePage(title: 'Flutter Demo Test Home Page'),
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
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextFormField(
                  onChanged: _handleEmailText,
                  decoration: InputDecoration(
                    hintText: 'メールアドレス',
                  )),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextFormField(
                  obscureText: true,
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
    ));
  }
}
