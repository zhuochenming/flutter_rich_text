import 'package:flutter/material.dart';
import 'package:flutter_rich_text/rich_text_widget.dart';

class ReaderWidget extends StatefulWidget {
  final String text;
  final int line;

  const ReaderWidget({super.key, required this.text, required this.line});

  @override
  State<StatefulWidget> createState() {
    return ReaderWidgetState();
  }
}

class ReaderWidgetState extends State<ReaderWidget> {
  late int line;

  @override
  void initState() {
    super.initState();
    line = widget.line;
  }

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
        text: widget.text,
        additionText: line == 1 ? '更多' : '更少',
        maxWidth: MediaQuery.of(context).size.width - 20,
        callback: () {
          line == 1 ? line = 5 : line = 1;
          setState(() {});
        },
        maxLines: line,
        style: const TextStyle(fontSize: 24, color: Colors.red),
        additionStyle: const TextStyle(fontSize: 24, color: Colors.green));
  }
}
