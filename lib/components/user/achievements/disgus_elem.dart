import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image/image.dart';
import 'package:intl/intl.dart';

import '../../shared/bubble_border.dart';
import '../../shared/expandable_text.dart';

class DisgusElem extends StatefulWidget {
  const DisgusElem({Key? key, required this.elem}) : super(key: key);

  final QueryDocumentSnapshot elem;

  @override
  _DisgusElemState createState() => _DisgusElemState();
}

class _DisgusElemState extends State<DisgusElem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 50,
              child: Image.asset(
                'images/pojimaru.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 40.0),
              decoration: ShapeDecoration(
                shape: BubbleBorder(
                  width: 50,
                  radius: 10,
                ),
              ),
              // child: Text(
              //   widget.elem.get('content'),
              //   overflow: TextOverflow.clip,
              // ),
              child: ExpandableText(
                maxLines: 4,
                textSpan: TextSpan(
                  text: widget.elem.get('content'),
                  style: TextStyle(color: Colors.black)
                ),
              )
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              child: Text(DateFormat('yyyy/MM/dd/HH:mm')
                  .format(widget.elem.get('createdAt').toDate())),
            ),
          ),
        ],
      ),
    );
  }
}
