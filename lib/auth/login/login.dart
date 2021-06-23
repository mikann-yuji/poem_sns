import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../home/home.dart';

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
  String _correctPassword = 'test';
  String _text = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  void _checkPassword() {
    if (_correctPassword == _text) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(title: 'Flutter Demo Test Home Page'),
        ),
      );

      setState(() {
        _isNotCorrectPassword = false;
      });
    } else {
      setState(() {
        _isNotCorrectPassword = true;
      });
    }
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
              child: TextField(
                enabled: true,
                onChanged: _handleText,
              )
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
              onPressed: _checkPassword,
            ),
            ElevatedButton(
              child: Text('新規登録する'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
              ),
              onPressed: _checkPassword,
            ),
          ],
        ),
      ),
    );
  }
}
