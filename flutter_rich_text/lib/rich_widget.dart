import 'package:flutter/material.dart';

class RichWidget extends StatefulWidget {
  ///文本
  final String text;

  ///最大宽度
  final double maxWidth;

  ///行数，不传 默认为1
  final int maxLines;

  final double appendWidth;
  final Widget? appendWidget;

  ///字体样式
  final TextStyle? style;

  const RichWidget(
      {super.key,
      required this.text,
      required this.maxWidth,
      this.maxLines = 1,
      this.appendWidth = 0,
      this.appendWidget,
      this.style});

  @override
  RichWidgetState createState() => RichWidgetState();
}

class RichWidgetState extends State<RichWidget> {
  String kText = '';
  int kMaxLines = 0;
  int kFontCount = 0;
  TextStyle? kStyle;

  bool kExceedMaxLines = false;

  @override
  Widget build(BuildContext context) {
    if (widget.appendWidget == null) {
      return SizedBox(
          width: widget.maxWidth,
          child: FutureBuilder(
              future: _didExceedMaxLines(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                return _showMoreText();
              }));
    }

    return SizedBox(
        width: widget.maxWidth,
        child: FutureBuilder(
            future: _didExceedMaxLines(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              return Row(children: [_showMoreText(), widget.appendWidget!]);
            }));
  }

  Widget _showMoreText() {
    if (kFontCount < 1) {
      return Container();
    }
    String content = widget.text.substring(0, kFontCount - 1);
    return RichText(
        maxLines: widget.maxLines,
        text: TextSpan(children: [
          TextSpan(text: content, style: widget.style),
          TextSpan(text: kExceedMaxLines ? '...' : '', style: widget.style)
        ]));
  }

  TextPainter _textPainterWithTextSpan(List<InlineSpan> children) {
    return TextPainter(
        maxLines: widget.maxLines,
        text: TextSpan(children: children),
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: widget.maxWidth - widget.appendWidth);
  }

  ///文字是否超出
  Future<bool> _didExceedMaxLines() async {
    if (kText == widget.text &&
        kStyle == widget.style &&
        kMaxLines == widget.maxLines) {
      return kExceedMaxLines;
    }
    kFontCount = _fontCounter();
    kText = widget.text;
    kMaxLines = widget.maxLines;
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
                style: widget.style)
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
