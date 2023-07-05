import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text("Hello Flutter")), body: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return (const Center(
      child: Text(
        "Hello",
        textDirection: TextDirection.ltr,
        style: TextStyle(color: Color.fromRGBO(204, 244, 123, 1), fontSize: 40),
      ),
    ));
  }
}
