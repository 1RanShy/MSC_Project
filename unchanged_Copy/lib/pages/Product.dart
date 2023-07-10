import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  //Flutter2.2.0之后需要注意把Key改为可空类型  {Key? key} 表示Key为可空类型
  ProductPage({Key? key}) : super(key: key);

  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('商品页面'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Flutter2.x中可以使用ElevatedButton 替代 RaisedButton,也可以继续使用RaisedButton
            ElevatedButton(
                child: Text("跳转到商品详情"),
                onPressed: () {
                  Navigator.pushNamed(context, '/productinfo',
                      arguments: {"pid": 456});
                }),
          ],
        ));
  }
}
