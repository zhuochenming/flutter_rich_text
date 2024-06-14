import 'package:flutter/cupertino.dart';

class SharedDataWidget extends InheritedWidget {
  final int data; //需要在子树中共享的数据，保存点击次数

  const SharedDataWidget({super.key, required this.data, required super.child});

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static SharedDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SharedDataWidget>();
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget重新build
  @override
  bool updateShouldNotify(SharedDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}
