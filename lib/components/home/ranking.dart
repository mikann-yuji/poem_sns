import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../redux/acitons/app_state_actions.dart';
import '../../redux/app_state.dart';
import '../../redux/view_model.dart';
import '../shared/flash_message.dart';
import '../shared/mo_rich_text.dart';

class Ranking extends StatefulWidget {
  const Ranking({Key? key, required this.originContext}) : super(key: key);

  final BuildContext originContext;

  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MoRichText(),
    );
  }
}
