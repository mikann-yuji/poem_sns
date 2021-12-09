// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:tuple/tuple.dart';

class RichTextEditor extends StatefulWidget {
  const RichTextEditor({Key? key}) : super(key: key);

  @override
  _RichTextEditorState createState() => _RichTextEditorState();
}

class _RichTextEditorState extends State<RichTextEditor> {
  QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.data.isControlPressed && event.character == 'b') {
          if (_controller
              .getSelectionStyle()
              .attributes
              .keys
              .contains('bold')) {
            _controller.formatSelection(Attribute.clone(Attribute.bold, null));
          } else {
            _controller.formatSelection(Attribute.bold);
          }
        }
      },
      child: _buildWelcomeEditor(context),
    );
  }

  Widget _buildWelcomeEditor(BuildContext context) {
    var quillEditor = QuillEditor(
        controller: _controller,
        scrollController: ScrollController(),
        scrollable: true,
        focusNode: _focusNode,
        autoFocus: false,
        readOnly: false,
        placeholder: 'Add content',
        expands: false,
        padding: EdgeInsets.zero,
        customStyles: DefaultStyles(
          h1: DefaultTextBlockStyle(
              const TextStyle(
                fontSize: 32,
                color: Colors.black,
                height: 1.15,
                fontWeight: FontWeight.w300,
              ),
              const Tuple2(16, 0),
              const Tuple2(0, 0),
              null),
          sizeSmall: const TextStyle(fontSize: 9),
        ));

    // var toolbar = QuillToolbar.basic(
    //   controller: _controller!,
    //   // provide a callback to enable picking images from device.
    //   // if omit, "image" button only allows adding images from url.
    //   // same goes for videos.
    //   onImagePickCallback: _onImagePickCallback,
    //   onVideoPickCallback: _onVideoPickCallback,
    //   // uncomment to provide a custom "pick from" dialog.
    //   // mediaPickSettingSelector: _selectMediaPickSetting,
    //   showAlignmentButtons: true,
    // );

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 15,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: quillEditor,
            ),
          ),
        ],
      ),
    );
  }
}
