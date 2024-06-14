import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rich_text/rich_text_widget.dart';
import 'package:flutter_rich_text/rich_widget.dart';
import 'package:flutter_rich_text/total_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '图文混排',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '图文混排'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  int line = 1;
  String additionText = '更多';

  Future<void> _incrementCounter() async {
    counter++;
    setState(() {});

    var result = await compute(getName, "name");
    if (kDebugMode) {
      print(result);
    }
  }

  static String getName(String name) {
    sleep(const Duration(seconds: 2));
    return "Name";
  }

  @override
  Widget build(BuildContext context) {
    String text = '在第一次正魔大战之中，困扰小凡多年的草庙村血案真相大白，小凡伤心激愤，'
        '道玄以诛仙剑欲除之。碧瑶以痴情咒为他挡下诛仙剑阵，魂飞魄散，张小凡叛出青云加入魔教，'
        '被鬼王赐名鬼厉。十年间，鬼厉杀人无数，冷漠嗜血的同时他也走遍大江南北，'
        '寻求救醒碧瑶的良方。十年后，鬼厉与陆雪琪、曾书书、林惊羽等再次相遇。';
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('You have pushed the button this many times:'),
          const TotalWidget(),
          RichTextWidget(
            text: text,
            additionText: additionText,
            callback: () {
              if (line == 1) {
                line = 5;
                additionText = '更少';
              } else {
                line = 1;
                additionText = '更多';
              }

              setState(() {});
            },
            maxWidth: MediaQuery.of(context).size.width - 20,
            maxLines: line,
            style: const TextStyle(color: Colors.black),
            additionStyle: const TextStyle(color: Colors.green),
          ),
          RichWidget(
            text: text,
            maxWidth: MediaQuery.of(context).size.width - 20,
            style: const TextStyle(color: Colors.amber),
            appendWidth: 120,
            appendWidget: ElevatedButton(
              style: const ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(Size(120, 44))),
              onPressed: () {
                setState(() {});

                showDialog(
                    context: context,
                    builder: (ctx) {
                      return Center(
                          child: Container(
                              margin: const EdgeInsets.all(100),
                              width: 300,
                              height: 80,
                              color: Colors.white,
                              child: const Text('点我干嘛',
                                  textAlign: TextAlign.center)));
                    });
              },
              child: const Text('点我'),
            ),
          ),
          Text('$counter', style: Theme.of(context).textTheme.headlineMedium)
        ])),
        floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add)));
  }
}
