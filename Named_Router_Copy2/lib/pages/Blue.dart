import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluePage extends StatefulWidget {
  final Map arguments;
  BluePage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<BluePage> createState() => _BluePageState();
}

class _BluePageState extends State<BluePage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  // bool isBlueOn = false;
  // bool hasPermission = false;
  List<BluetoothDevice> blueList = [];
  List<ScanResult> test = [];
  int rssi = 0;

  //获取设备
  late BluetoothDevice device;
  //获取设备连接的状态
  String deviceState = "";
  //判断页面是否销毁
  bool isDesponse = false;
  //获取读写的特征值
  late BluetoothCharacteristic mCharacteristicRead;
  late BluetoothCharacteristic mCharacteristicWrite;
  late String _password0;
  late String _password1;
  late String _password2;
  String show = "initialize";
  @override
  void initState() {
    super.initState();
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
      });

      //print(AsciiDecoder().convert(value));  //表示Ascii转换成字符串
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${this.deviceState}")),
      body: Container(
        child: Column(
          children: [
            //------------------------
            TextField(
              maxLines: 3,
              obscureText: false,
              decoration: InputDecoration(hintText: "Password"),
              onChanged: (value) {
                setState(() {
                  this._password2 = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 80,
              child: ElevatedButton(
                  onPressed: () async {
                    final command = this._password2;
                    final convertedCommand = AsciiEncoder().convert(command);

                    // await this.mCharacteristics.write([97, 98]);
                    await this.mCharacteristicWrite.write(convertedCommand);
                  },
                  child: Text("发送消息")),
            ),

            Text("Rssi"),
            Text(
              rssi.toString(),
              style: TextStyle(color: Colors.blue),
              overflow: TextOverflow.ellipsis, //超出用...代替
              softWrap: false,
            ),
            ElevatedButton(
                onPressed: () async {
                  this.scanDevice();
                },
                child: Text("扫描设备")),

            SizedBox(
              height: 20,
            ),
            Text("以下是文本显示框"),
            Text(
              show,
              style: TextStyle(color: Colors.blue),
              overflow: TextOverflow.ellipsis, //超出用...代替
              softWrap: false,
            ),
          ],
        ),
      ),
    );
  }
}
