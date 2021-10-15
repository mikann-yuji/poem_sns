import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../redux/app_state.dart';
import '../../../redux/view_model.dart';
import '../../../user/circle_avatar_image.dart';
import './achievement_count.dart';
import '../setting/setting.dart';
import '../achievements/bes_posi_index.dart';
import '../achievements/disgus_index.dart';
import '../achievements/encou_index.dart';
import '../../shared/disgus_post_button.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('マイページ'),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: StoreConnector<AppState, ViewModel>(
          converter: (store) => ViewModel.fromStore(store),
          builder: (context, viewModel) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          CircleAvatarImage(
                              radius: 75,
                              imageURL: viewModel.currentUser.imageURL),
                          Container(
                            margin: EdgeInsets.only(left: 15.0),
                            child: Text(viewModel.currentUser.username,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.settings, size: 40.0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Setting()),
                        );
                      },
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AchievementCount(
                        title: 'いやな\nこと',
                        count: 15,
                        transitionPageFunction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DisgusIndex(uid: viewModel.currentUser.uid)),
                          );
                        },
                      ),
                      AchievementCount(
                        title: 'はげました\nこと',
                        count: 30,
                        transitionPageFunction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EncouIndex(uid: viewModel.currentUser.uid)),
                          );
                        },
                      ),
                      AchievementCount(
                        title: 'ベスト\nポジティブ',
                        count: 3,
                        transitionPageFunction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BesPosiIndex(uid: viewModel.currentUser.uid)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        )
      ),
      floatingActionButton: DisgusPostButton(contextP: context),
    );
  }
}
