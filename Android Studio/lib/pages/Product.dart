import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vibration/vibration.dart';

class ProductPage extends StatefulWidget {
  //Flutter2.2.0之后需要注意把Key改为可空类型  {Key? key} 表示Key为可空类型
  ProductPage({Key? key}) : super(key: key);

  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //__________Timer_______________
  int cc = 0;
  late Timer _timer;
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      // 在这里执行你的函数
      cc++;
      print(cc);
    });
  }

  void stopTimer(Timer timer) {
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
  }
//_____________Speech To Text_________________

  SpeechToText _speechToText = SpeechToText();
  SpeechToText _speechToText2 = SpeechToText();
  bool _speechEnabled = false;
  bool _speechEnabled2 = false;
  String _lastWords = '';
  String _lastWords2 = '';

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

//----------------------------------
  /// This has to happen only once per app
  void _initSpeech2() async {
    _speechEnabled = await _speechToText2.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening2() async {
    await _speechToText2.listen(onResult: _onSpeechResult2);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening2() async {
    await _speechToText2.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult2(SpeechRecognitionResult result) {
    setState(() {
      _lastWords2 = result.recognizedWords;
    });
  }

  //_______________Phone Data Srore______________________________________
  String _phonenumber = "Enter The number you want to call";
  _saveData() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('_phonenumber', _phonenumber);
  }

  _getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _phonenumber = prefs.getString('_phonenumber')!;
    });
  }

//_______________initstate___________________
  @override
  void initState() {
    super.initState();
    _initSpeech();
    _initSpeech2();
    startTimer();
    _getData();
  }

  //__________________dispose_____
  @override
  void dispose() {
    _saveData();
    stopTimer(_timer);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Tooltip(
          message: "Call number and open google map in this Page",
          child: Text('Contact Functions'),
        ),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        color: Colors.grey, // 设置深绿色背景
        child: Column(
          children: [
            Tooltip(
              message: "Enter the number you want to call",
              child: TextField(
                maxLines: 3,
                obscureText: false,
                decoration: InputDecoration(
                    hintText: "Enter the number you want to call"),
                keyboardType: TextInputType.number, // 设置键盘类型为数字键盘
                onChanged: (value) {
                  setState(() {
                    this._phonenumber = value;
                  });
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 6, right: 3),
                    child: ElevatedButton(
                      onPressed: () {
                        Vibration.vibrate(duration: 500);
                        _launchPhoneCall(_phonenumber);
                      },
                      child: Text('Call The Number'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 3, right: 6),
                    child: ElevatedButton(
                      onPressed: () {
                        Vibration.vibrate(duration: 500);
                        _saveData();
                      },
                      child: Text('Save the Number'),
                    ),
                  ),
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () {
                Vibration.vibrate(duration: 500);
                _launchPhoneCall('07754660823');
              },
              child: Text('Emergency Contact'),
            ),
            // ElevatedButton(
            //   onPressed: _launchGoogleMaps,
            //   child: Text('Google Maps'),
            // ),
            // // Text("以下是文本显示框"),
            // Text(
            //   "initiale",
            //   style: TextStyle(color: Colors.blue),
            //   overflow: TextOverflow.ellipsis, //超出用...代替
            //   softWrap: false,
            // ),
            // Container(
            //   color: Colors.grey, // 设置深绿色背景
            //   padding: EdgeInsets.all(16),
            //   child: Text(
            //     'Recognized words:',
            //     style: TextStyle(fontSize: 20.0),
            //   ),
            // ),
            // Container(
            //   color: Colors.grey, // 设置深绿色背景
            //   padding: EdgeInsets.all(16),
            //   child: Text(
            //       // If listening is active show the recognized words
            //       '$_lastWords'
            //       // If listening isn't active but could be tell the user
            //       // how to start it, otherwise indicate that speech
            //       // recognition is not yet ready or not supported on
            //       // the target device
            //       ),
            // ),

            ElevatedButton(
              onPressed: () {
                Vibration.vibrate(duration: 500);
                if (_speechToText.isNotListening) {
                  _startListening();
                } else {
                  _stopListening();
                }
                print(
                    "----------------------------------------------------------");
                // if (X.contains("call")) {
                //   print("1234-------------");
                // }
              },
              // If not yet listening for speech start, otherwise stop

              child: Icon(
                  _speechToText.isNotListening ? Icons.mic_off : Icons.mic),
            ),
            ElevatedButton(
              onPressed: () {
                Vibration.vibrate(duration: 500);
                print(_lastWords);
                // voice recognize
                // String x = match?.group(0) ?? '';
                String x = extractNumbers(_lastWords);
                if (_lastWords.contains("call") ||
                    _lastWords.contains("Call")) {
                  _phonenumber = x;
                  _launchPhoneCall(x);
                }
                if (_lastWords.contains("Google") ||
                    _lastWords.contains("google")) {
                  _launchGoogleMaps();
                }
                print(x);
              },
              // If not yet listening for speech start, otherwise stop

              child: Text("Make Sure"),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       // HapticFeedback.vibrate();
            //       Vibration.vibrate(duration: 500);
            //     },
            //     child: Text("Vibration"))
          ],
        ),
      ),
    );
  }

  String extractNumbers(String input) {
    // 使用正则表达式提取数字
    RegExp regExp = RegExp(r'\d+');
    Iterable<Match> matches = regExp.allMatches(input);

    // 将提取的数字组合成一个字符串
    String result = matches.map((match) => match.group(0)).join('');

    return result;
  }

  // 拨打电话
  void _launchPhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Can not dial ：$url';
    }
  }

// 打开Google Maps
  void _launchGoogleMaps() async {
    final latitude = 37.7749; // 目标位置的纬度
    final longitude = -122.4194; // 目标位置的经度

    final url = 'geo:$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Can not open Google Maps';
    }
  }
}
