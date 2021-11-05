import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../firebase/firestore/get_disgusting_post.dart';
import './disgus_elem.dart';

class DisgusIndex extends StatefulWidget {
  const DisgusIndex({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  _DisgusIndexState createState() => _DisgusIndexState();
}

class _DisgusIndexState extends State<DisgusIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('いやなこと一覧'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getDisgustingPost(widget.uid),
            builder: (BuildContext context,
                AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    for (QueryDocumentSnapshot elem in snapshot.data!)
                      DisgusElem(elem: elem),
                  ]
                );
              } else {
                return Text('データがありません');
              }
            }
          )
        ),
      ),
    );
  }
}
