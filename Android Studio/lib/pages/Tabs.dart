import 'package:flutter/material.dart';
import 'tabs/Home.dart';
import 'tabs/Category.dart';
import 'tabs/Setting.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Tabs extends StatefulWidget {
  //Flutter2.2.0之后需要注意把Key改为可空类型  {Key? key} 表示Key为可空类型
  Tabs({Key? key}) : super(key: key);

  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  List _pageList = [
    HomePage(),
    CategoryPage(),
    SettingPage(),
  ];

//__________________________________________________________
  TextEditingController textEditingController = TextEditingController();
  FlutterTts flutterTts = FlutterTts();
  void textToSpeech(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }
//__________________________________________________________

  void initState() {
    // TODO: implement initState
    textToSpeech("Tap Page to Connect your Equipment");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Last 10 Meters")),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.brown, // 设置背景颜色为棕色
        ),
        body: Container(
          color: Colors.grey, // 设置深绿色背景

          child: this._pageList[this._currentIndex],
        )

        //以下是显示底部导航栏的代码
        );
  }
}
