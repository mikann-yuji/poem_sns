import 'package:flutter/material.dart';

extension _TextMeasurer on RichText {
  List<TextBox> measure(BuildContext context, BoxConstraints constraints) {
    final renderObject = createRenderObject(context)..layout(constraints);
    final boxes = renderObject.getBoxesForSelection(
      TextSelection(
        baseOffset: 0,
        extentOffset: text.toPlainText().length,
      ),
    );
    return boxes;
  }
}

class ExpandableText extends StatefulWidget {
  final TextSpan textSpan;
  final int maxLines;

  const ExpandableText(
      {Key? key,
      required this.textSpan,
      required this.maxLines})
      : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  // static const String _ellipsis = "\u2026\u0020";
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final maxLines = widget.maxLines;

      final richText = Text.rich(widget.textSpan).build(context) as RichText;
      final boxes = richText.measure(context, constraints);

      if (boxes.length <= maxLines) {
        return Column(children: [
            RichText(text: widget.textSpan),
        ]);
      } else {
        double _calculateLinesLength(List<TextBox> boxes) => boxes
            .map((box) => box.bottom - box.top)
            .reduce((acc, value) => acc += value);
        final requiredLength =
            _calculateLinesLength(boxes.sublist(0, maxLines));
        final totalLength = _calculateLinesLength(boxes);

        return Column(children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: _isExpanded
                ? totalLength
                : requiredLength,
            child: RichText(
              text: widget.textSpan,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton(
            onPressed: () => setState(() {
              _isExpanded = !_isExpanded;
            }),
            child: _isExpanded ? Text('閉じる') : Text('続きを読む'),
            style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(100, 30))),
          )
        ]);
      }
    });
  }
}
