import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../auth/login/login.dart';
import '../redux/acitons/app_state_actions.dart';
import '../redux/app_state.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          InkWell(
            onTap: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            child: Center(
              child: StoreConnector<AppState, ViewModel>(
                converter: (store) => ViewModel.fromStore(store),
                builder: (context, viewModel) {
                  if (viewModel.isLogin) {
                    return Text('アカウント');
                  } else {
                    return Text('ログイン');
                  }
                },
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('お気に入り'),
            ),
            ListTile(
              title: Text('ランキング'),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: LoginPage(title: 'ログインする'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            StoreConnector<AppState, ViewModel>(
              converter: (store) => ViewModel.fromStore(store),
              builder: (context, viewModel) {
                return Text(
                  'redux で増える: ${viewModel.counter.toString()} ${viewModel.isLogin.toString()}',
                );
              },
            ),
            // AddUser('サンプル　太郎', 'サンプル株式会社', 55),
            StoreConnector<AppState, VoidCallback>(
              converter: (store) {
                return () => store.dispatch(AppStateActions.Increment);
              },
              builder: (context, callback) {
                return ElevatedButton(
                  child: Text(
                    'reduxで数字をふやす',
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    onPrimary: Colors.white,
                  ),
                  onPressed: callback,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddUser extends StatelessWidget {
  final String fullName;
  final String company;
  final int age;

  AddUser(this.fullName, this.company, this.age);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'full_name': fullName, // John Doe
            'company': company, // Stokes and Sons
            'age': age // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}

class ViewModel {
  final int counter;
  final bool isLogin;

  ViewModel({
    required this.counter,
    required this.isLogin,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return new ViewModel(
      counter: store.state.counter,
      isLogin: store.state.isLogin,
    );
  }
}
