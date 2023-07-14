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
        print("Already Turn Bluetooth");
        setState((() {
          this.isBlueOn = true;
        }));
        requestPermission();
      } else {
        print("Bluetooth is off");
        setState((() {
          this.isBlueOn = false;
        }));
      }
    });
  }

  // 动态权限
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
                if (device.name == "Equipment") {
                  return ListTile(
                    title: Text("Double click to  connect Your ${device.name}"),
                    onTap: () {
                      Navigator.pushNamed(context, '/blue',
                          arguments: {"device": device});
                    },
                  );
                } else {
                  return Container(); // 返回一个空容器代替不需要的ListTile
                }
              }).toList(),
            )
          : this.isBlueOn
              ? Container(
                  child: this.hasPermission
                      ? Text("Do not get any devices")
                      : Text("No permission to bluetooth"),
                )
              : Text("Please turn on the Bluetooth"),
    );
  }
}
        //自动扫描设备名字为Equipment的设备然后连接上他
        // if (device.name == "Equipment") {
        //   Navigator.pushNamed(context, '/blue',
        //       arguments: {"device": device});
        //   print("__________________");
        // } else {}