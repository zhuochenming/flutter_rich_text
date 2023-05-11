import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextWidget extends StatefulWidget {
  ///文本
  final String text;

  ///附加文本
  final String additionText;

  ///最大宽度
  final double maxWidth;

  ///回调
  final Function() callback;

  ///行数，不传 默认为1
  final int maxLines;

  ///字体样式
  final TextStyle? style;

  ///附加字体样式
  final TextStyle? additionStyle;

  const RichTextWidget(
      {Key? key,
      required this.text,
      required this.additionText,
      required this.callback,
      required this.maxWidth,
      this.maxLines = 1,
      this.style,
      this.additionStyle})
      : super(key: key);

  @override
  RichTextWidgetState createState() => RichTextWidgetState();
}

class RichTextWidgetState extends State<RichTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: _didExceedMaxLines()
            ? _showMoreText()
            : Text(widget.text, style: widget.style));
  }

  Widget _showMoreText() {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: widget.text.substring(0, _fontCounter()),
        style: widget.style,
      ),
      TextSpan(children: [
        TextSpan(text: '...', style: widget.style),
        TextSpan(
            text: widget.additionText,
            style: widget.additionStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                widget.callback();
              })
      ])
    ]));
  }

  TextPainter _textPainterWithTextSpan(List<InlineSpan> children) {
    return TextPainter(
        maxLines: widget.maxLines,
        text: TextSpan(children: children),
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: widget.maxWidth);
  }

  ///文字是否超出
  static String kText = '';
  static TextStyle? kStyle;
  static bool kExceedMaxLines = false;

  bool _didExceedMaxLines() {
    if (kText == widget.text && kStyle == widget.style) {
      return kExceedMaxLines;
    }
    kText = widget.text;
    kStyle = widget.style;
    kExceedMaxLines = _textPainterWithTextSpan(
        [TextSpan(text: widget.text, style: widget.style)]).didExceedMaxLines;
    return kExceedMaxLines;
  }

  ///计算最多可容纳正常字的个数
  int _fontCounter() {
    int num = 0;
    int skip = 1;
    while (true) {
      bool isExceed = widget.text.length < num + skip ||
          _textPainterWithTextSpan([
            TextSpan(
                text: '${widget.text.substring(0, num + skip)}...',
                style: widget.style),
            TextSpan(text: widget.additionText, style: widget.additionStyle)
          ]).didExceedMaxLines;
      if (!isExceed) {
        num = num + skip;
        skip *= 2;
        continue;
      }
      if (isExceed && skip == 1) {
        return num;
      }
      skip = skip ~/ 2;
    }
  }
}
