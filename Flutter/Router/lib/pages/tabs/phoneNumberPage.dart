import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
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
      _phone = _prefs?.getString('lastPhoneNumber') ?? '';
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);

    // Save phone number to SharedPreferences
    await _prefs?.setString('lastPhoneNumber', phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    final Uri toLaunch =
        Uri(scheme: 'https', host: 'www.cylog.org', path: 'headers/');
    return Scaffold(
      appBar: AppBar(
        title: const Text('URL Launcher'),
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
                  decoration: const InputDecoration(
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
