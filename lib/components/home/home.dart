import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../redux/acitons/app_state_actions.dart';
import '../../redux/app_state.dart';
import '../../redux/view_model.dart';
import '../shared/flash_message.dart';
import '../../firebase/firestore/get_disgusting_post_at_home.dart';
import '../user/achievements/disgus_elem.dart';
import '../shared/expandable_text.dart';
import '../shared/test_rich_text.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.originContext}) : super(key: key);

  final BuildContext originContext;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: FutureBuilder(
              future: getDisgustingPostAtHome(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    // RichTextEditor(),
                    // QuillToolbar.basic(controller: _controller),
                    // Expanded(
                    //   child: Container(
                    //     child: QuillEditor.basic(
                    //       controller: _controller,
                    //       readOnly: false, // true for view only mode
                    //     ),
                    //   ),
                    // ),
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
                          onPressed: () =>
                              viewModel.dispatch(new IncrementAction()),
                        );
                      },
                    ),
                    for (QueryDocumentSnapshot elem in snapshot.data!)
                      DisgusElem(elem: elem),
                    FlashMessage(originContext: widget.originContext),
                  ]);
                } else {
                  return Text('データがありません');
                }
              })),
    );
  }
}
