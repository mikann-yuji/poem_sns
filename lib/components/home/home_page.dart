import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../auth/login/login.dart';
import '../../user/circle_avatar_image.dart';
import '../../ranking_icons.dart';
import 'swipe_page.dart';
import '../../redux/app_state.dart';
import '../../redux/view_model.dart';
import '../../redux/acitons/app_state_actions.dart';
import '../user/my_page/my_page.dart';
import '../shared/disgus_post_button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController pageController = PageController(
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          StoreConnector<AppState, ViewModel>(
              converter: (store) => ViewModel.fromStore(store),
              builder: (context, viewModel) {
                if (viewModel.isLogin) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyPage()),
                      );
                    },
                    child: CircleAvatarImage(
                        radius: 80, imageURL: viewModel.currentUser.imageURL),
                  );
                } else {
                  return InkWell(
                    onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
                    child: Center(
                      child: Text('ログイン'),
                    ),
                  );
                }
              })
        ],
      ),
      endDrawer: Drawer(
          child: StoreConnector<AppState, ViewModel>(
        converter: (store) => ViewModel.fromStore(store),
        builder: (context, viewModel) {
          return LoginPage(title: 'ログインする');
        },
      )),
      body: SwipePage(
        originContext: context,
        pageController: pageController,
      ),
      bottomNavigationBar: StoreConnector<AppState, ViewModel>(
          converter: (store) => ViewModel.fromStore(store),
          builder: (context, viewModel) {
            return BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Ranking.podium),
                    label: 'ランキング',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'ホーム',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.style),
                    label: 'カテゴリ',
                  ),
                ],
                currentIndex: viewModel.swipePageIndex.index,
                onTap: (int index) {
                  viewModel
                      .dispatch(new ChangeSwipePageIndexAction(index: index));
                  pageController.jumpToPage(index);
                });
          }),
      floatingActionButton: DisgusPostButton(contextP: context,),
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
