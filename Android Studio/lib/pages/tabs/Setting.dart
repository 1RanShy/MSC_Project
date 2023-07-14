import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  //Flutter2.2.0之后需要注意把Key改为可空类型  {Key? key} 表示Key为可空类型
  SettingPage({Key? key}) : super(key: key);

  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text("我是一个文本"),
        ),
        ListTile(
          title: Text("我是一个文本"),
        ),
        ListTile(
          title: Text("我是一个文本"),
        ),
        ListTile(
          title: Text("我是一个文本"),
        ),
        ElevatedButton(
          child: Text("跳转到登录页面"),
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
        ),
        ElevatedButton(
          child: Text("跳转到注册页面"),
          onPressed: () {
            Navigator.pushNamed(context, '/registerFirst');
          },
        ),
        ElevatedButton(
          child: Text("蓝牙界面测试"),
          onPressed: () {
            Navigator.pushNamed(context, '/remotePage');
          },
        ),
        ElevatedButton(
          child: Text("PDF阅读器测试界面"),
          onPressed: () {
            Navigator.pushNamed(context, '/pdf');
          },
        ),
      ],
    );
  }
}
