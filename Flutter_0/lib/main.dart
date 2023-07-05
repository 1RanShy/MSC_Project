import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('FloatingActionButton Example'),
        ),
        body: Center(
          child: Text('Content'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // 按下按钮时执行的操作
            print('FloatingActionButton pressed');
          },
          child: const Icon(Icons.add), // 按钮上显示的图标
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: [BottomNavigationBarItem(icon: Icon(Icons.home))]),
      ),
    );
  }
}
