import 'package:flutter/material.dart';

class RegisterThirdPage extends StatelessWidget {
  //Flutter2.2.0之后需要注意把Key改为可空类型  {Key? key} 表示key为可空类型
  const RegisterThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("第三步-完成注册")
      ),body:Center(
        child: Column(
        children: <Widget>[
          SizedBox(height: 40),
          Text("输入密码完成注册"),
          SizedBox(height: 40),
          ElevatedButton(
            child: Text('确定'),
            onPressed: (){              
                Navigator.of(context).pop();
            },
          )
        ],
      ),
      )
    );
  }
}