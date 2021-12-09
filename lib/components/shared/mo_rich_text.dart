import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import 'dart:math' as math;

class MoQuillController extends QuillController {
  TextSelection MoSelection = TextSelection.collapsed(offset: 0);

  MoQuillController(
      {required Document document, required TextSelection selection})
      : super(document: document, selection: selection) {
    MoSelection = selection;
  }

  void _updateSelection(TextSelection textSelection, ChangeSource source) {
    MoSelection = textSelection;
    final end = document.length - 1;
    MoSelection = selection.copyWith(
        baseOffset: math.min(selection.baseOffset, end),
        extentOffset: math.min(selection.extentOffset, end));
  }

  void testFormatText(int index, int len, Attribute? attribute) {
    if (len == 0 &&
        attribute!.isInline &&
        attribute.key != Attribute.link.key) {
      toggledStyle = toggledStyle.put(attribute);
    }

    final change = document.format(index, len, attribute);
    final adjustedSelection = selection.copyWith(
        baseOffset: change.transformPosition(selection.baseOffset),
        extentOffset: change.transformPosition(selection.extentOffset));
    if (selection != adjustedSelection) {
      _updateSelection(adjustedSelection, ChangeSource.LOCAL);
    }
  }

  void updateSelection(TextSelection textSelection, ChangeSource source) {
    _updateSelection(textSelection, source);
  }
}

class MoRichText extends StatefulWidget {
  const MoRichText({Key? key}) : super(key: key);

  @override
  _MoRichTextState createState() => _MoRichTextState();
}

class _MoRichTextState extends State<MoRichText> {
  MoQuillController _controller = MoQuillController(
      document: Document(), selection: TextSelection.collapsed(offset: 0));
  FocusNode _focusNode = FocusNode();
  List rowList = [];
  List resultList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_controllerListener);
  }

  void _controllerListener() {
    rowList = [];
    resultList = [];
    int charIndex = -1;
    Iterable<RegExpMatch> matches =
        RegExp(r'.+\n').allMatches(_controller.plainTextEditingValue.text);
    for (RegExpMatch match in matches) {
      rowList.add(match.group(0));
    }

    for (int i = 0; i < rowList.length; i++) {
      List charList = rowList[i].split('');
      charList.insert(0, ' ');
      charList.add(' ');
      bool hashSta = false;
      bool hashEnd = false;
      List hashList = [];

      for (int j = 1; j < (charList.length - 1); j++) {
        charIndex += 1;
        if ((charList[j] == '#' &&
                RegExp(r'\s').hasMatch(charList[j - 1]) &&
                RegExp(r'[^\s]').hasMatch(charList[j + 1])) ||
            hashSta) {
          if (charList[j] == '#' && !hashSta) {
            _controller.testFormatText(
                charIndex, 1, ColorAttribute('#00acee'));
          }
          hashSta = true;
          if (RegExp(r'\s').hasMatch(charList[j + 1])) {
            hashSta = false;
            hashEnd = true;
            hashList.add(charList[j]);
            resultList.add(hashList.join(''));
            _controller.testFormatText(
                charIndex + 1, 1, ColorAttribute('#000000'));
            hashList = [];
          } else {
            hashSta = true;
            hashEnd = false;
          }

          if (hashSta && !hashEnd) {
            hashList.add(charList[j]);
            _controller.testFormatText(
                charIndex + 1, 1, ColorAttribute('#00acee'));
          }
        }
      }
      if (hashList.isNotEmpty) {
        resultList.add(hashList.join(''));
      }
    }

    print(resultList);
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        RawKeyboardListener(
          focusNode: FocusNode(),
          child: Container(
            height: 200.0,
            color: Colors.white,
            child: QuillEditor(
              controller: _controller,
              scrollController: ScrollController(),
              scrollable: true,
              focusNode: _focusNode,
              autoFocus: true,
              readOnly: false,
              expands: false,
              padding: EdgeInsets.zero,
              keyboardAppearance: Brightness.light,
            ),
          ),
        ),
      ]),
    );
  }
}
