import 'package:flutter/cupertino.dart';

class RefreshWidget extends StatefulWidget {
  // final int data;
  //
  // const RefreshWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RefreshWidgetState();
  }
}

class RefreshWidgetState extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text('RefreshWidget');
  }
}
