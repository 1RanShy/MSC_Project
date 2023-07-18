# Speech to Text

```dart
/*
最终s
*/
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpeechToText _speechToText = SpeechToText();
  SpeechToText _speechToText2 = SpeechToText();
  bool _speechEnabled = false;
  bool _speechEnabled2 = false;
  String _lastWords = '';
  String _lastWords2 = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _initSpeech2();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                    // If listening is active show the recognized words
                    '$_lastWords'
                    // If listening isn't active but could be tell the user
                    // how to start it, otherwise indicate that speech
                    // recognition is not yet ready or not supported on
                    // the target device
                    ),
              ),
            ),
            ElevatedButton(
              onPressed:
                  // If not yet listening for speech start, otherwise stop
                  _speechToText.isNotListening
                      ? _startListening
                      : _stopListening,
              child: Icon(
                  _speechToText.isNotListening ? Icons.mic_off : Icons.mic),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                    // If listening is active show the recognized words
                    '$_lastWords2'
                    // If listening isn't active but could be tell the user
                    // how to start it, otherwise indicate that speech
                    // recognition is not yet ready or not supported on
                    // the target device
                    ),
              ),
            ),
            ElevatedButton(
              onPressed:
                  // If not yet listening for speech start, otherwise stop
                  _speechToText2.isNotListening
                      ? _startListening2
                      : _stopListening2,
              child: Icon(
                  _speechToText2.isNotListening ? Icons.mic_off : Icons.mic),
            ),
          ],
        ),
      ),
    );
  }
}

```









```dart
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpeechToText _speechToText = SpeechToText();
  SpeechToText _speechToText2 = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  String _lastWords2 = '';
  String key1 = "1";
  String key2 = "2";
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  void _onSpeechResult2(SpeechRecognitionResult result2) {
    setState(() {
      _lastWords2 = result2.recognizedWords;
    });
  }

  test() {
    return (Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            'Recognized words:',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Text(
                // If listening is active show the recognized words
                '$_lastWords'
                // If listening isn't active but could be tell the user
                // how to start it, otherwise indicate that speech
                // recognition is not yet ready or not supported on
                // the target device

                ),
          ),
        ),
        Tooltip(
          message: 'This is a tooltip',
          child: ElevatedButton(
            onPressed: () {
              if (_speechToText.isNotListening) {
                _speechToText.listen(onResult: _onSpeechResult);
                setState(() {});
              } else {
                _speechToText.stop();
                setState(() {});
              }
            },
            // If not yet listening for speech start, otherwise stop

            child:
                Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
          ),
        )
      ],
    ));
  }

  test2(SpeechToText x, y) {
    return (Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            'Recognized words:',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Text(
                // If listening is active show the recognized words
                '$_lastWords2'
                // If listening isn't active but could be tell the user
                // how to start it, otherwise indicate that speech
                // recognition is not yet ready or not supported on
                // the target device

                ),
          ),
        ),
        Tooltip(
          message: 'This is a tooltip',
          child: ElevatedButton(
            onPressed: () {
              if (x.isNotListening) {
                x.listen(onResult: y);
                setState(() {});
              } else {
                x.stop();
                setState(() {});
              }
            },
            // If not yet listening for speech start, otherwise stop

            child: Icon(x.isNotListening ? Icons.mic_off : Icons.mic),
          ),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech Demo'),
      ),
      body: Center(
          child: Column(
        children: [test(), test2(_speechToText2, _onSpeechResult2)],
      )),
    );
  }
}

```

```dat
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                    // If listening is active show the recognized words
                    '$_lastWords'
                    // If listening isn't active but could be tell the user
                    // how to start it, otherwise indicate that speech
                    // recognition is not yet ready or not supported on
                    // the target device
                    ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}

```

```dart
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SpeechToText _speechToText = SpeechToText();
  SpeechToText _speechToText2 = SpeechToText();
  bool _speechEnabled = false;
  bool _speechEnabled2 = false;
  String _lastWords = '';
  String _lastWords2 = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _initSpeech2();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                    // If listening is active show the recognized words
                    '$_lastWords'
                    // If listening isn't active but could be tell the user
                    // how to start it, otherwise indicate that speech
                    // recognition is not yet ready or not supported on
                    // the target device
                    ),
              ),
            ),
            ElevatedButton(
              onPressed:
                  // If not yet listening for speech start, otherwise stop
                  _speechToText.isNotListening
                      ? _startListening
                      : _stopListening,
              child: Icon(
                  _speechToText.isNotListening ? Icons.mic_off : Icons.mic),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recognized words:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                    // If listening is active show the recognized words
                    '$_lastWords2'
                    // If listening isn't active but could be tell the user
                    // how to start it, otherwise indicate that speech
                    // recognition is not yet ready or not supported on
                    // the target device
                    ),
              ),
            ),
            ElevatedButton(
              onPressed:
                  // If not yet listening for speech start, otherwise stop
                  _speechToText2.isNotListening
                      ? _startListening2
                      : _stopListening2,
              child: Icon(
                  _speechToText2.isNotListening ? Icons.mic_off : Icons.mic),
            ),
          ],
        ),
      ),
    );
  }
}

```

# Text  To Speech

```dart
import 'package:flutter_tts/flutter_tts.dart';  
//____________________________________
  TextEditingController textEditingController = TextEditingController();
  FlutterTts flutterTts = FlutterTts();
  int c = 0;
  void textToSpeech(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }




ElevatedButton(
    onPressed: () {
        setState(() {
            c++;
        });

        textEditingController.text = "Hello World ${c.toString()}";//文本
        textToSpeech(textEditingController.text);//朗读文本
    },
    child: Text('Change Text'),
)
```

# Bluetooth

```dart
onPressed: () async {
    final command = this._code0;
    final convertedCommand = AsciiEncoder().convert(command);

    // await this.mCharacteristics.write([97, 98]);
    await this.mCharacteristicWrite.write(convertedCommand);
},
String show //是这里面的蓝牙接收字符串
    		//并且是自动接收并转换的
/*
- 收的是字符串没错
- 发一定是将字符串转为 ASCII码再发出去
*/
```



