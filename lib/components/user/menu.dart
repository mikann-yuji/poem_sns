import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../functions/make_dialog.dart';

class UserMenu extends StatefulWidget {
  const UserMenu({Key? key}) : super(key: key);

  @override
  _UserMenuState createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  void confirmSignOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        ListTile(title: Text('プロフィールの編集')),
        ListTile(
          title: Text('メールアドレスの変更'),
        ),
        ListTile(
          title: Text('パスワードの変更'),
        ),
        ListTile(
          title: Text('投稿一覧'),
        ),
        ListTile(
          title: Text(
            'ログアウト',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () => makeDialog(
            context,
            '確認',
            '本当にログアウトしますか？',
            'キャンセル',
            'ログアウト',
            confirmSignOut
          )
        ),
      ],
    ));
  }
}
