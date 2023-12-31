import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

// import 'package:flutter/services.dart'
class BluePage extends StatefulWidget {
  final Map arguments;
  BluePage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<BluePage> createState() => _BluePageState();
}

class _BluePageState extends State<BluePage> {
  //_____________Timer_________________
  //__________Timer_______________
  int cc = 0;
  String distance = "";
  String x = "";
  late Timer _timer;
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 8), (Timer timer) {
      // 在这里执行你的函数
      try {
        scanDevice();
        textToSpeech(
            "Front ${rssiFrontDifference.toString()} Left ${rssiLeftDifference.toString()} Right ${rssiRightDifference.toString()} ");
        // textToSpeech("Right ${rssiRightDifference.toString()}");
        // textToSpeech("Right ${rssiRightDifference.toString()}");
        throw Exception('蓝牙扫描注册失败');
      } catch (e) {
        // 捕获异常，并执行相应的函数
        scanDevice();
      }

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
  String _phonenumber2 = "1021";
  _saveData() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('_phonenumber2', _phonenumber2);
  }

  _getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _phonenumber2 = prefs.getString('_phonenumber2')!;
    });
  }

  //-----------------------------------
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> blueList = [];
  List<ScanResult> test = [];
  int rssi = 0;
  int rssiLeft = 0;
  int rssiLeftDifference = 0;
  int rssiRight = 0;
  int rssiRightDifference = 0;
  int rssiFront = 0;
  int rssiFrontDifference = 0;

  int time = 1;

  //获取设备
  late BluetoothDevice device;
  //获取设备连接的状态
  String deviceState = "";
  //判断页面是否销毁
  bool isDesponse = false;
  //获取读写的特征值
  late BluetoothCharacteristic mCharacteristicRead;
  late BluetoothCharacteristic mCharacteristicWrite;
  late String _code0;
  late String _code1;

  String show = "Initialize";
//_______________________________
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

//___
  @override
  void initState() {
    super.initState();
    time = 1;
    _initSpeech();
    _initSpeech2();
    startTimer();
    _getData();
    //获取设备
    this.device = widget.arguments["device"];
    // print(this.device);
    //连接蓝牙
    this.device.connect();
    //监听蓝牙状态
    this.device.state.listen((state) {
      if (this.isDesponse == false) {
        if (state == BluetoothDeviceState.connected) {
          setState(() {
            this.deviceState = "Success to Connect your equipment";
          });
          //发现服务
          this.discoverServices();
        } else if (state == BluetoothDeviceState.connecting) {
          setState(() {
            this.deviceState = "connecting...";
          });
        } else if (state == BluetoothDeviceState.disconnected) {
          setState(() {
            this.deviceState = "disconnected...";
          });
        }
      }
    });
  }

  @override
  void dispose() {
    this.isDesponse = true;
    this.device.disconnect();
    stopTimer(_timer);
    _saveData();

    super.dispose();
  }

  void scanDevice() {
    // Start scanning
    flutterBlue.startScan(timeout: Duration(milliseconds: 1500));

    // Listen to scan results
    flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
        if (r.device.name == "Equipment") {
          print("----------------------------------------------");
          print(r);
        }
//获取蓝牙设备的名字和rssi  之后改为BluetoothDevice这个变量更加合适,可以存储更详细的信息
        if (r.device.name == "RanShuai") {
          print("--------------------------------------------");
          setState(() {
            rssi = r.rssi;
          });
        }

        //获取蓝牙设备的名字和rssi  之后改为BluetoothDevice这个变量更加合适,可以存储更详细的信息
        if (r.device.name == "Left") {
          print("--------------------------------------------");
          setState(() {
            print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
            rssiLeft = r.rssi;
            rssiLeftDifference = 80 + rssiLeft;
            print("rssiLeftDifference");
          });
          if (time > 0) {
            print("You are now near the entrance");
            textToSpeech("You are now near the entrance");
            time--;
          }
        }

        //获取蓝牙设备的名字和rssi  之后改为BluetoothDevice这个变量更加合适,可以存储更详细的信息
        if (r.device.name == "Right") {
          print("--------------------------------------------");
          setState(() {
            print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
            rssiRight = r.rssi;
            rssiRightDifference = 80 + rssiRight;
            print("rssiRIghtDifference");
          });
          if (time > 0) {
            print("You are now near the entrance");
            textToSpeech("You are now near the entrance");
            time--;
          }
        }

        //获取蓝牙设备的名字和rssi  之后改为BluetoothDevice这个变量更加合适,可以存储更详细的信息
        if (r.device.name == "Front") {
          print("--------------------------------------------");
          setState(() {
            print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
            rssiFront = r.rssi;
            rssiFrontDifference = 80 + rssiFront;
            print("rssiFrontDifference");
          });
          if (time > 0) {
            print("You are now near the entrance");
            textToSpeech("You are now near the entrance");
            time--;
          }
        }

        if (r.device.name.length > 2) {
          if (this.blueList.indexOf(r.device) == -1) {
            setState(() {
              this.blueList.add(r.device);
              this.test.add(r);
            });
          }
        }
      }
    });
  }

  discoverServices() async {
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      // do something with service
      print("-------------serviceUUID----------------");
      print("${service.uuid}");
      // 0000ffe1-0000-1000-8000-00805f9b34fb  厂商发给我们可以读写的UUID
      if (service.uuid.toString() == "0000ffe0-0000-1000-8000-00805f9b34fb") {
        print("-------------获取服务成功----------------");
        var characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          if (c.uuid.toString() == "0000ffe1-0000-1000-8000-00805f9b34fb") {
            print("-------------获取特征值成功----------------");
            this.mCharacteristicRead = c;
            //定时器 获取蓝牙模块里面的数据
            // const timeout = const Duration(seconds: 5);
            // Timer(timeout, () {
            // });
            dataCallbackBle();
          }
          if (c.uuid.toString() == "0000ffe2-0000-1000-8000-00805f9b34fb") {
            print("可以发送");
            this.mCharacteristicWrite = c;
          }
        }
      }
    });
  }

  //读取蓝牙模块穿过来的消息
  dataCallbackBle() async {
    await this.mCharacteristicRead.setNotifyValue(true);
    this.mCharacteristicRead.value.listen((value) {
      if (value == null) {
        print("我是蓝牙返回数据 - 空！！");
        return;
      }
      print(value);
      print(String.fromCharCodes(value)); //表示Ascii转换成字符串
      setState(() {
        show = String.fromCharCodes(value);
        if (show.contains("Unsafe")) Vibration.vibrate(duration: 200);
      });

      //print(AsciiDecoder().convert(value));  //表示Ascii转换成字符串
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Tooltip(
          message: "Success to Connect your Device",
          child: Text("Successful"),
        ),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.grey,
      body: Container(
        width: screenWidth,
        height: screenHeight / 2,
        color: Colors.grey, // 设置深绿色背景
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Text("越大越近越小越远"),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Text("Left: ${rssiLeft.toString()}"),
            //     Text("Dif: ${rssiLeftDifference.toString()}"),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Text("Right: ${rssiRight.toString()}"),
            //     Text("Dif: ${rssiRightDifference.toString()}"),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Text("Front: ${rssiFront.toString()}"),
            //     Text("Dif: ${rssiFrontDifference.toString()}"),
            //   ],
            // ),

            // //------------------------
            // TextField(
            //   maxLines: 3,
            //   obscureText: false,
            //   decoration: InputDecoration(hintText: "_code0"),
            //   onChanged: (value) {
            //     setState(() {
            //       this._code0 = value;
            //     });
            //   },
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   width: MediaQuery.of(context).size.width - 20,
            //   height: 80,
            //   child: ElevatedButton(
            //       onPressed: () async {
            //         final command = this._code0;
            //         final convertedCommand = AsciiEncoder().convert(command);

            //         // await this.mCharacteristics.write([97, 98]);
            //         await this.mCharacteristicWrite.write(convertedCommand);
            //       },
            //       child: Text("发送消息")),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text("RanShuai : "),
            //     Text(
            //       rssi.toString(),
            //       style: TextStyle(color: Colors.blue),
            //       overflow: TextOverflow.ellipsis, //超出用...代替
            //       softWrap: false,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text("Left : "),
            //     Text(
            //       rssiLeft.toString(),
            //       style: TextStyle(color: Colors.blue),
            //       overflow: TextOverflow.ellipsis, //超出用...代替
            //       softWrap: false,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text("Right : "),
            //     Text(
            //       rssiRight.toString(),
            //       style: TextStyle(color: Colors.blue),
            //       overflow: TextOverflow.ellipsis, //超出用...代替
            //       softWrap: false,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text("Front : "),
            //     Text(
            //       rssiFront.toString(),
            //       style: TextStyle(color: Colors.blue),
            //       overflow: TextOverflow.ellipsis, //超出用...代替
            //       softWrap: false,
            //     ),
            //   ],
            // ),

            // ElevatedButton(
            //     onPressed: () async {
            //       this.scanDevice();
            //     },
            //     child: Text("Scan The Devices")),

            // SizedBox(
            //   height: 20,
            // ),

            // // Text("以下是文本显示/蓝牙数据显示"),
            // Text(
            //   show,
            //   style: TextStyle(color: Colors.blue),
            //   overflow: TextOverflow.ellipsis, //超出用...代替
            //   softWrap: false,
            // ),

            Tooltip(
              message: "Press this button to jump to Contact Page",
              child: ElevatedButton(
                onPressed: () {
                  Vibration.vibrate(duration: 500);
                  Navigator.pushNamed(context, '/product');
                },
                // If not yet listening for speech start, otherwise stop

                child: Text("Jump to Next Page"),
              ),
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Vibration.vibrate(duration: 500);
                    print("-------------------");
                    print(_lastWords);

                    // String x = match?.group(0) ?? '';
                    // voice recognize
                    String x = extractNumbers(_lastWords);
                    if (_lastWords.contains("Set") ||
                        _lastWords.contains("set")) {
                      distance = x;

                      final command = distance;
                      final convertedCommand = AsciiEncoder().convert(command);

                      // await this.mCharacteristics.write([97, 98]);
                      await this.mCharacteristicWrite.write(convertedCommand);
                    }

                    if (_lastWords.contains("Far") ||
                        _lastWords.contains("far")) {
                      textToSpeech("${show} centimeters");
                    }

                    // print("_______________________________________");
                    // print(x);
                  },
                  // If not yet listening for speech start, otherwise stop

                  child: Text("Make Sure"),
                ),
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
              ],
            ),
            ExcludeSemantics(
              excluding: true,
              child: Tooltip(
                message: "Perform gestures in this area.",
                child: GestureDetector(
                  onTap: () {
                    // 处理轻按（单击）的逻辑
                    print("轻按了屏幕");
                  },
                  onLongPress: () {
                    // 处理长按的逻辑
                    print("长按了屏幕");
                  },
                  onPanUpdate: (details) {
                    // 处理拖动的逻辑
                    // Vibration.vibrate(duration: 500);
                    print("拖动了屏幕，位置：${details.globalPosition}");
                  },
                  onVerticalDragUpdate: (details) {
                    // 获取垂直方向上滑动的距离
                    double dy = details.delta.dy;

                    if (dy > 0) {
                      // 用户向下滑动
                      print("用户向下滑动，滑动距离：$dy");
                      Vibration.vibrate(duration: 500);
                      textToSpeech("${show} centimeters");
                    } else if (dy < 0) {
                      // 用户向上滑动
                      Vibration.vibrate(duration: 500);
                      Navigator.pushNamed(context, '/product');
                      print("用户向上滑动，滑动距离：$dy");
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        'Gestures area.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      //_________________________________
    );
  }
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
    throw '无法拨打电话：$url';
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
    throw '无法打开Google Maps';
  }
}
