import 'package:flutter/material.dart';


class RegisterSecondPage extends StatelessWidget {
   //Flutter2.2.0之后需要注意把Key改为可空类型  {Key? key} 表示key为可空类型
  const RegisterSecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("第二步-验证码")
      ),body:Column(
        children: <Widget>[
          SizedBox(height: 40),
          Text("输入验证码完成注册"),
          SizedBox(height: 40),
          ElevatedButton(
            child: Text('下一步'),
            onPressed: (){
                // Navigator.pushNamed(context, '/registerSecond');

                //替换路由
                Navigator.of(context).pushReplacementNamed('/registerThird');
            },
          )
        ],
      )
    );
  }
}