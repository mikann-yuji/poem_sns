import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../auth/login/login.dart';
import '../user/menu.dart';
import '../../user/circle_avatar_image.dart';
import '../../redux/acitons/app_state_actions.dart';
import '../../redux/app_state.dart';
import './post_form_modal.dart';
import '../../redux/view_model.dart';
import '../../ranking_icons.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
                    return CircleAvatarImage(
                        radius: 80, imageURL: viewModel.currentUser.imageURL);
                  } else {
                    return Text('ログイン');
                  }
                },
              ),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
          child: StoreConnector<AppState, ViewModel>(
        converter: (store) => ViewModel.fromStore(store),
        builder: (context, viewModel) {
          if (viewModel.isLogin) {
            return UserMenu();
          } else {
            return LoginPage(title: 'ログインする');
          }
        },
      )),
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
                  'redux で増える: ${viewModel.counter.toString()} ${viewModel.isLogin.toString()} ${viewModel.currentUser.username}',
                );
              },
            ),
            StoreConnector<AppState, ViewModel>(
              converter: (store) => ViewModel.fromStore(store),
              builder: (context, viewModel) {
                return ElevatedButton(
                  child: Text(
                    'reduxで数字をふやす',
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () => viewModel.dispatch(new IncrementAction()),
                );
              },
            ),
            StoreConnector<AppState, ViewModel>(
                converter: (store) => ViewModel.fromStore(store),
                onDidChange: (prev, next) {
                  if (next.flashMessageState.flag) {
                    print('動いた');
                    final snackBar =
                        SnackBar(content: Text(next.flashMessageState.content));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                builder: (context, viewModel) {
                  if (viewModel.flashMessageState.flag) {
                    viewModel.dispatch(
                        new ChangeFlashMessageState(flag: false, content: ''));
                    return Container();
                  } else {
                    return Container();
                  }
                })
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ranking.podium),
            label: 'ランキング',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.style),
            label: 'カテゴリ',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => postFormModal(context),
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
            'full_name': fullName,
            'company': company,
            'age': age,
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
