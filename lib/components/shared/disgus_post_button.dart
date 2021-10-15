import 'package:flutter/material.dart';

import '../home/post_form_modal.dart';

class DisgusPostButton extends StatelessWidget {
  const DisgusPostButton({Key? key, required this.contextP}) : super(key: key);

  final BuildContext contextP;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => postFormModal(contextP),
      child: Icon(Icons.add),
    );
  }
}
