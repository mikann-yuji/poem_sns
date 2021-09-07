import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import './components/error/error.dart';
import './components/load/load.dart';
import './components/home/home.dart';
import './redux/app_state.dart';
import './redux/reducer/app_state_reducer.dart';
import './redux/acitons/app_state_actions.dart';
import './firebase/firestore/get_user.dart';
import './firebase/firestorage/get_avatar_image.dart';

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
              widget.store.dispatch(new LogoutAction());
            } else {
              getUser(user.uid).then((currentUserData) {
                getAvatarImage(user.uid).then((imageURL) {
                  widget.store.dispatch(new AddCurrentUserAction(
                    username: currentUserData.get('username'),
                    email: currentUserData.get('email'),
                    uid: currentUserData.get('uid'),
                    imageURL: imageURL,
                  ));
                });
              });
              widget.store.dispatch(new LoginAction());
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
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Flutter Demo Test Home Page'),
    );
  }
}
