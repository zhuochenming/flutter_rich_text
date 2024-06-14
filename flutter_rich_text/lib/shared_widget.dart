import 'package:flutter/cupertino.dart';
import 'package:flutter_rich_text/shared_data_widget.dart';

class SharedWidget extends StatefulWidget {
  const SharedWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return SharedWidgetState();
  }
}

class SharedWidgetState extends State<SharedWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(SharedDataWidget.of(context)!.data.toString());
  }
}
