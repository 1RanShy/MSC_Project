import 'package:flutter/material.dart';


import 'global.dart';
import 'routes/Routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  int set() {
    Global.xaaa = 0;
    return Global.xaaa;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // home:Tabs(),
        initialRoute: '/', //初始化的时候加载的路由
        onGenerateRoute: onGenerateRoute);
  }
}
