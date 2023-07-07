//测试是否能在程序关闭之后保存电话信息
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

/*
          电话号码设置

1. 在输入电话号码处输入电话号码.
2. 即使你关闭应用,下次当你按下call number时间.也会回拨上次你输入的号码
3. 而且不是通话记录里的上次,而是上次你输入的号码.

-------------------防止误触---------------
为了防止误触弹出设置电话号码的窗口 只有两种办法
1. 跳转到另一个界面设置电话号码
2. 将设置电话号码的提示栏设置的非常上面,非常小


              跳转App     
 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedPhoneNumber = prefs.getString('lastPhoneNumber');

  runApp(MyApp(savedPhoneNumber: savedPhoneNumber));
}

class MyApp extends StatelessWidget {
  final String? savedPhoneNumber;

  const MyApp({Key? key, this.savedPhoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Launcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'URL Launcher',
        savedPhoneNumber: savedPhoneNumber,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String? savedPhoneNumber;

  const MyHomePage({Key? key, required this.title, this.savedPhoneNumber})
      : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences? _prefs;
  bool _hasCallSupport = false;
  Future<void>? _launched;
  String _phone = '';

  @override
  void initState() {
    super.initState();
    initSharedPreferences();

    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });

    final lastPhoneNumber = _prefs?.getString('lastPhoneNumber') ?? '';
    setState(() {
      _phone = lastPhoneNumber;
    });
  }

  Future<void> initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _phone = widget.savedPhoneNumber ?? '';
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);

    // 保存电话号码到 SharedPreferences
    await _prefs?.setString('lastPhoneNumber', phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch =
        Uri(scheme: 'https', host: 'www.cylog.org', path: 'headers/');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (String text) => _phone = text,
                  decoration: InputDecoration(
                      hintText: 'Input the phone number to launch'),
                ),
              ),
              ElevatedButton(
                onPressed:
                    _hasCallSupport ? () => _makePhoneCall(_phone) : null,
                child: _hasCallSupport
                    ? const Text('Make phone call')
                    : const Text('Calling not supported'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(toLaunch.toString()),
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  _launched = _launchInBrowser(toLaunch);
                }),
                child: const Text('Launch in browser'),
              ),
              const Padding(padding: EdgeInsets.all(16.0)),
              ElevatedButton(
                onPressed: () => setState(() {
                  _launched = _launchInWebViewOrVC(toLaunch);
                }),
                child: const Text('Launch in app'),
              ),
              const Padding(padding: EdgeInsets.all(16.0)),
              FutureBuilder<void>(
                future: _launched,
                builder: _launchStatus,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }
}
