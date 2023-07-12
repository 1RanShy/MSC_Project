import 'dart:async';
import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:flutter/material.dart';

class Ibeacon extends StatefulWidget {
  @override
  _IbeaconState createState() => _IbeaconState();
}

class _IbeaconState extends State<Ibeacon> {
  List<String> _results = [];

  final StreamController<String> beaconEventsController =
      StreamController<String>.broadcast();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    beaconEventsController.close();
    super.dispose();
  }

  Future<void> initPlatformState() async {
    BeaconsPlugin.listenToBeacons(beaconEventsController);

    // 添加要监测的iBeacon区域
    await BeaconsPlugin.addRegion(
        "BeaconType1", "8ec76ea3-6668-48da-9866-75be8bc86f4d");
    await BeaconsPlugin.addRegion(
        "BeaconType2", "6a84c716-0f2a-1ce9-f210-6a63bd873dd9");

    beaconEventsController.stream.listen((data) {
      if (data.isNotEmpty) {
        setState(() {
          _results.add(data);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitoring Beacons'),
      ),
      body: ListView.builder(
        itemCount: _results.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_results[index]),
          );
        },
      ),
    );
  }
}
