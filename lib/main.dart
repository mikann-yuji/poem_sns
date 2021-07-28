import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import './error/error.dart';
import './load/load.dart';
import './home/home.dart';
import './redux/app_state.dart';
import './redux/reducer/app_state_reducer.dart';
import './redux/acitons/app_state_actions.dart';
import './firestore/get_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState.loading(),
  );

  runApp(App(
    store: store,
  ));
}

class App extends StatefulWidget {
  final Store<AppState> store;

  App({Key? key, required this.store}) : super(key: key);
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          FirebaseAuth.instance.authStateChanges().listen((User? user) {
            if (user == null) {
              print('User signed out');
              widget.store.dispatch(AppStateActions.Logout);
            } else {
              print('User signed in');
              print(user.uid);
              widget.store.dispatch(AppStateActions.Login);
            }
          });
          // Check for errors
          if (snapshot.hasError) {
            return Error();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MyApp();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Loading();
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Test Home Page'),
    );
  }
}
