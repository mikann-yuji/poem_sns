import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './setting_item.dart';
import '../../../functions/make_dialog.dart';
import '../../home/home_page.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  void confirmSignOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomePage(title: 'ポジ変')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('設定'),
      ),
      body: Container(
        margin:
            EdgeInsets.only(top: 30.0, right: 20.0, bottom: 20.0, left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingItem(itemName: 'ユーザー名', margin: 0.0),
                SettingItem(itemName: '電話番号', margin: 15.0),
                SettingItem(itemName: 'メールアドレス', margin: 15.0),
                SettingItem(itemName: 'パスワード', margin: 15.0),
                Divider(
                  height: 40,
                  thickness: 3,
                ),
                SettingItem(itemName: 'アカウント削除', margin: 15.0),
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 150.0),
                  child: ElevatedButton(
                    onPressed: () {
                      print('サインアウト、動いてる');
                      makeDialog(
                          context, '確認', '本当にログアウトしますか？', 'キャンセル', 'ログアウト', () {
                        confirmSignOut(context);
                      });
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.only(
                          top: 10.0, right: 20.0, bottom: 10.0, left: 20.0)),
                    ),
                    child: Text(
                      'ログアウト',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
