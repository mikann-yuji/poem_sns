import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../firebase/firestore/get_disgusting_post.dart';

class DisgusIndex extends StatefulWidget {
  const DisgusIndex({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  _DisgusIndexState createState() => _DisgusIndexState();
}

class _DisgusIndexState extends State<DisgusIndex> {
  late List<QueryDocumentSnapshot>? _index;

  @override
  Widget build(BuildContext context) {
    getDisgustingPost(widget.uid).then((posts) {
      print(posts[1].get('content'));
      setState(() => _index = posts);
    });

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('いやなこと一覧'),
        ),
        body: Container(
          child: Text('disgus'),
        ));
  }
}
