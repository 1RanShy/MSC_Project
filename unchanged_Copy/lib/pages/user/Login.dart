import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  //Flutter2.2.0之后需要注意把Key改为可空类型  {Key? key} 表示key为可空类型
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("登录")),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Text('这是一个登录页面,点击登录会执行登录操作'),
            ElevatedButton(
              child: Text("立即登录"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
