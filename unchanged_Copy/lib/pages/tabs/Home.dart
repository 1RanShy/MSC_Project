import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  //Flutter2.2.0之后需要注意把Key改为可空类型  {Key? key} 表示Key为可空类型
  HomePage({Key? key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //obtain an instance
  FlutterBlue flutterBlue = FlutterBlue.instance;
  bool isBlueOn = false;
  bool hasPermission = false;
  List<BluetoothDevice> blueList = [];
  @override
  void initState() {
    super.initState();
    //监听蓝牙是否开启
    flutterBlue.state.listen((state) {
      if (state == BluetoothState.on) {
        print("蓝牙已经开启");
        setState((() {
          this.isBlueOn = true;
        }));
        requestPermission();
      } else {
        print("蓝牙未开启");
        setState((() {
          this.isBlueOn = false;
        }));
      }
    });
  }

  // 动态申请权限
  Future<bool> requestPermission() async {
    // 申请权限
    bool hasBluetoothPermission = await requestBluePermission();
    if (hasBluetoothPermission) {
      print("蓝牙权限申请通过");
      setState(() {
        this.hasPermission = true;
      });
      //扫描设备
      this.scanDevice();
    } else {
      print("蓝牙权限申请不通过");
      this.hasPermission = false;
    }
    return hasBluetoothPermission;
  }

  //扫描设备的方法
  void scanDevice() {
    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    // Listen to scan results
    flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
        if (r.device.name.length > 2) {
          if (this.blueList.indexOf(r.device) == -1) {
            setState(() {
              this.blueList.add(r.device);
            });
          }
        }
      }
    });
  }

  //申请蓝牙权限  授予定位权限返回true， 否则返回false
  Future<bool> requestBluePermission() async {
    //获取当前的权限
    var status = await Permission.bluetooth.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.bluetooth.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: this.blueList.length > 0
          ? Column(
              children: this.blueList.map((device) {
                return ListTile(
                  title: Text("${device.name}    ${device.id}"),
                  onTap: () {
                    Navigator.pushNamed(context, '/blue',
                        arguments: {"device": device});
                  },
                );
              }).toList(),
            )
          : this.isBlueOn
              ? Container(
                  child: this.hasPermission ? Text("没有扫描到设备") : Text("没有蓝牙权限"),
                )
              : Text("没有打开蓝牙"),
    );
  }
}
/*
        ElevatedButton(
          child: Text("跳转到搜索页面"),
          onPressed: () {
            //路由跳转
            Navigator.pushNamed(context, '/search', arguments: {"id": 123});
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
            child: Text("跳转到商品页面"),
            onPressed: () {
              Navigator.pushNamed(context, '/product');
            }),
 */