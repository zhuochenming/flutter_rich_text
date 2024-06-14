import 'package:flutter/material.dart';
import 'package:flutter_rich_text/refresh_widget.dart';
import 'package:flutter_rich_text/shared_data_widget.dart';
import 'package:flutter_rich_text/shared_widget.dart';

class TotalWidget extends StatefulWidget {
  const TotalWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return TotalWidgetState();
  }
}

class TotalWidgetState extends State<TotalWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        width: 200,
        child: SharedDataWidget(
            data: count,
            child: Column(children: [
              const SharedWidget(),
              RefreshWidget(),
              TextButton(
                  onPressed: () {
                    count++;
                    setState(() {});
                  },
                  child: const Text('点我'))
            ])));
  }
}
