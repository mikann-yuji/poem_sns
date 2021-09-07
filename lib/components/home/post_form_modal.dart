import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../redux/acitons/app_state_actions.dart';
import '../../redux/app_state.dart';
import '../../redux/view_model.dart';
import '../../firebase/firestore/add_post.dart';

void postFormModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) => PostModal(),
  );
}

class PostModal extends StatelessWidget {
  const PostModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (context) => MaterialPageRoute<ModalPage>(
        builder: (context) => StoreConnector<AppState, ViewModel>(
            converter: (store) => ViewModel.fromStore(store),
            builder: (context, viewModel) {
              return ModalPage(reduxContent: viewModel.postContent.content);
            }),
      ),
    );
  }
}

class ModalPage extends StatefulWidget {
  const ModalPage({Key? key, required this.reduxContent}) : super(key: key);

  final String reduxContent;

  @override
  _ModalPageState createState() => _ModalPageState();
}

class _ModalPageState extends State<ModalPage> {
  late String _message;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _message = widget.reduxContent;

    _controller = TextEditingController(text: _message);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          // Need to use root Navigator, not nested Navigator
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          icon: Icon(Icons.close),
        ),
        title: Text('Modal'),
        actions: [
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ModalDetailPage()),
            ),
            child: Container(
              margin: EdgeInsets.only(right: 18.0),
              child: Center(child: Text('確認')),
            ),
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: StoreConnector<AppState, ViewModel>(
            converter: (store) => ViewModel.fromStore(store),
            builder: (context, viewModel) {
              return TextField(
                controller: _controller,
                autofocus: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (val) {
                  viewModel.dispatch(new ChangePostContentAction(content: val));
                },
              );
            },
          )),
    );
  }
}

class ModalDetailPage extends StatelessWidget {
  Future<void> sendPost(String? content, String? uid) {
    return addPost(content: content, uid: uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modal Detail'),
        actions: [
          StoreConnector<AppState, ViewModel>(
              converter: (store) => ViewModel.fromStore(store),
              builder: (context, viewModel) {
                return IconButton(
                  onPressed: () async {
                    await sendPost(viewModel.postContent.content,
                        viewModel.currentUser.uid);
                    viewModel
                        .dispatch(new ChangePostContentAction(content: ''));
                    Navigator.of(context, rootNavigator: true).pop();
                    await new Future.delayed(new Duration(milliseconds: 300));
                    final snackBar = SnackBar(content: Text('送信しました'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  icon: Icon(Icons.send),
                );
              }),
        ],
      ),
      body: Container(
        child: Center(
          child: StoreConnector<AppState, ViewModel>(
            converter: (store) => ViewModel.fromStore(store),
            builder: (context, viewModel) {
              return Text(viewModel.postContent.content);
            },
          ),
        ),
      ),
    );
  }
}
