import 'package:flutter/material.dart';

class BesPosiIndex extends StatelessWidget {
  const BesPosiIndex({Key? key, required this.uid}) : super(key: key);

  final String uid;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('ベストポジティブ一覧'),
        ),
        body: Container(
          child: Text('bes_posi'),
        ));
  }
}
