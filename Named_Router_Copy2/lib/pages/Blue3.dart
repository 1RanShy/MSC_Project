import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import "dart:async";
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluePage3 extends StatefulWidget {
  final Map arguments;
  BluePage3({Key? key, required this.arguments}) : super(key: key);

  @override
  State<BluePage3> createState() => _BluePage3State();
}

class _BluePage3State extends State<BluePage3> {
  //获取设备
  late BluetoothDevice device;
  //获取设备连接的状态
  String deviceState = "";
  //判断页面是否销毁
  bool isDesponse = false;
  //获取读写的特征值
  late BluetoothCharacteristic mCharacteristicRead;
  late BluetoothCharacteristic mCharacteristicWrite;
  late String _password0 = "test";
  late String _password1 = "up";
  late String _password2 = "down";
  String show = "initialize";
  Color? color1 = Colors.white;
  Color? color2 = Colors.white;
  Color? color3 = Colors.black;
  Color? color4 = Colors.black;
  Color? color5 = Colors.black;
  Color? color6 = Colors.white;
  Color? color7 = Colors.white;
  Color? color8 = Colors.white;
  Color? color9 = Colors.white;
  Color? color10 = Colors.white;
  late Timer timer1; //定时器 1s回调一次
  Widget container(
      {double x = 10,
      double height = 100,
      double width = 100,
      Color colorInside = Colors.blue,
      Color colorBorder = Colors.white,
      double borderWidth = 2,
      Widget? child}) {
    return Container(
        height: height,
        width: width,
        child: child,
        decoration: BoxDecoration(
            color: colorInside,
            border: Border.all(
              color: colorBorder,
              width: borderWidth,
            ),
            borderRadius: BorderRadius.all(Radius.circular(x))));
  }

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
            this.deviceState = "连接成功";
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
      backgroundColor: Color.fromARGB(255, 38, 37, 37),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 55, 54, 54),
          title: Text("${this.deviceState}")),
      body: Container(

          // height: 800,
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //设置容器宽度为屏幕宽度减去40
                    container(
                        x: 20,
                        colorInside: Colors.transparent,
                        colorBorder: Color.fromARGB(255, 148, 122, 236),
                        width: MediaQuery.of(context).size.width - 40,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // GestureDetector(),
                            Listener(
                              child: container(
                                  colorInside: Colors.transparent,
                                  width: 40,
                                  height: 40,
                                  x: 40,
                                  colorBorder: Colors.transparent,
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: color1,
                                    size: 40,
                                  )),
                              onPointerDown: (event)  {
                                color1 = Colors.blue;
                                print("onPointerDown");
                                print(222222);
                                setState(() {});
                                timer1 = Timer.periodic(Duration(seconds: 1),
                                    (timer) async {
                                  print(222222);
                                  final command = this._password1;
                                  final convertedCommand =
                                      AsciiEncoder().convert(command);

                                  // await this.mCharacteristics.write([97, 98]);
                                  await this
                                      .mCharacteristicWrite
                                      .write(convertedCommand);
                                  //timer.cancel();
                                });
                              },
                              onPointerUp: (event) {
                                color1 = Colors.white;
                                print("onPointer");
                                timer1.cancel();
                                setState(() {});
                              },
                            ),
                            Text(
                              "Headreset",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Listener(
                              child: container(
                                  colorInside: Colors.transparent,
                                  width: 40,
                                  height: 40,
                                  x: 40,
                                  colorBorder: Colors.transparent,
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: color2,
                                    size: 40,
                                  )),
                              onPointerDown: (event) {
                                color2 = Colors.blue;
                                print("onPointerDown");
                                print(222222);
                                setState(() {});
                                timer1 = Timer.periodic(Duration(seconds: 1),
                                    (timer)async {
                                  print(222222);
                                   final command = this._password2;
                                  final convertedCommand =
                                      AsciiEncoder().convert(command);

                                  // await this.mCharacteristics.write([97, 98]);
                                  await this
                                      .mCharacteristicWrite
                                      .write(convertedCommand);
                                  //timer.cancel();
                                });
                              },
                              onPointerUp: (event) {
                                color2 = Colors.white;
                                print("onPointer");
                                timer1.cancel();
                                setState(() {});
                              },
                            ),
                          ],
                        )),
                  ],
                ),
                //----------------------house-------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    container(
                      width: 250,
                      height: 250,
                      x: 250,
                      colorInside: Colors.white,
                      colorBorder: Color.fromARGB(255, 158, 202, 239),
                      borderWidth: 6.0,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Listener(
                              child: container(
                                  colorInside: Colors.transparent,
                                  width: 40,
                                  height: 40,
                                  x: 40,
                                  colorBorder: Colors.transparent,
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: color3,
                                    size: 40,
                                  )),
                              onPointerDown: (event) {
                                color3 = Colors.blue;
                                print("onPointerDown");
                                print(222222);
                                setState(() {});
                                timer1 = Timer.periodic(Duration(seconds: 1),
                                    (timer) async{
                                  print(222222);
                                   final command = "upup";
                                  final convertedCommand =
                                      AsciiEncoder().convert(command);

                                  // await this.mCharacteristics.write([97, 98]);
                                  await this
                                      .mCharacteristicWrite
                                      .write(convertedCommand);
                                  //timer.cancel();
                                });
                              },
                              onPointerUp: (event) {
                                color3 = Colors.black;
                                print("onPointer");
                                timer1.cancel();
                                setState(() {});
                              },
                            ),
                            Listener(
                              child: container(
                                  colorInside: Colors.transparent,
                                  width: 40,
                                  height: 40,
                                  x: 40,
                                  colorBorder: Colors.transparent,
                                  child: Icon(
                                    Icons.house,
                                    color: color4,
                                    size: 40,
                                  )),
                              onPointerDown: (event) {
                                color4 = Colors.blue;
                                print("onPointerDown");
                                print(222222);
                                setState(() {});
                                timer1 = Timer.periodic(Duration(seconds: 1),
                                    (timer) async{
                                  print(222222);
                                   final command = "home home";
                                  final convertedCommand =
                                      AsciiEncoder().convert(command);

                                  // await this.mCharacteristics.write([97, 98]);
                                  await this
                                      .mCharacteristicWrite
                                      .write(convertedCommand);
                                  //timer.cancel();
                                });
                              },
                              onPointerUp: (event) {
                                color4 = Colors.black;
                                print("onPointer");
                                timer1.cancel();
                                setState(() {});
                              },
                            ),
                            Listener(
                              child: container(
                                  colorInside: Colors.transparent,
                                  width: 40,
                                  height: 40,
                                  x: 40,
                                  colorBorder: Colors.transparent,
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: color5,
                                    size: 40,
                                  )),
                              onPointerDown: (event) {
                                color5 = Colors.blue;
                                print("onPointerDown");
                                print(222222);
                                setState(() {});
                                timer1 = Timer.periodic(Duration(seconds: 1),
                                    (timer) async{
                                  print(222222);
                                   final command = "down down";
                                  final convertedCommand =
                                      AsciiEncoder().convert(command);

                                  // await this.mCharacteristics.write([97, 98]);
                                  await this
                                      .mCharacteristicWrite
                                      .write(convertedCommand);
                                  //timer.cancel();
                                });
                              },
                              onPointerUp: (event) {
                                color5 = Colors.black;
                                print("onPointer");
                                timer1.cancel();
                                setState(() {});
                              },
                            ),
                          ]),
                    ),
                  ],
                ),
                //----------------------Lumbar-------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    container(
                        x: 20,
                        colorInside: Colors.transparent,
                        colorBorder: Color.fromARGB(255, 148, 122, 236),
                        width: MediaQuery.of(context).size.width - 40,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Listener(
                              child: container(
                                  colorInside: Colors.transparent,
                                  width: 40,
                                  height: 40,
                                  x: 40,
                                  colorBorder: Colors.transparent,
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: color6,
                                    size: 40,
                                  )),
                              onPointerDown: (event) {
                                color6 = Colors.blue;
                                print("onPointerDown");
                                print(222222);
                                setState(() {});
                                timer1 = Timer.periodic(Duration(seconds: 1),
                                    (timer) async{
                                  print(222222);
                                   final command ="upup up";
                                  final convertedCommand =
                                      AsciiEncoder().convert(command);

                                  // await this.mCharacteristics.write([97, 98]);
                                  await this
                                      .mCharacteristicWrite
                                      .write(convertedCommand);
                                  //timer.cancel();
                                });
                              },
                              onPointerUp: (event) {
                                color6 = Colors.white;
                                print("onPointer");
                                timer1.cancel();
                                setState(() {});
                              },
                            ),
                            Text(
                              "Lumbar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Listener(
                              child: container(
                                  colorInside: Colors.transparent,
                                  width: 40,
                                  height: 40,
                                  x: 40,
                                  colorBorder: Colors.transparent,
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: color7,
                                    size: 40,
                                  )),
                              onPointerDown: (event) {
                                color7 = Colors.blue;
                                print("onPointerDown");
                                print(222222);
                                setState(() {});
                                timer1 = Timer.periodic(Duration(seconds: 1),
                                    (timer) async{
                                  print(222222);
                                   final command = "down down";
                                  final convertedCommand =
                                      AsciiEncoder().convert(command);

                                  // await this.mCharacteristics.write([97, 98]);
                                  await this
                                      .mCharacteristicWrite
                                      .write(convertedCommand);
                                  //timer.cancel();
                                });
                              },
                              onPointerUp: (event) {
                                color7 = Colors.white;
                                print("onPointer");
                                timer1.cancel();
                                setState(() {});
                              },
                            ),
                          ],
                        )),
                  ],
                ),
                //----------------------4-------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    container(
                      width: 80,
                      height: 80,
                      x: 80,
                      colorInside: Colors.transparent,
                      colorBorder: Colors.blue,
                      child: Listener(
                        child: container(
                            colorInside: Colors.transparent,
                            width: 40,
                            height: 40,
                            x: 40,
                            colorBorder: Colors.transparent,
                            child: Icon(
                              Icons.map,
                              color: color8,
                              size: 40,
                            )),
                        onPointerDown: (event) {
                          color8 = Colors.blue;
                          print("onPointerDown");
                          print(222222);
                          setState(() {});
                          timer1 =
                              Timer.periodic(Duration(seconds: 1), (timer) async{
                            print(222222);
                             final command = "map map";
                                  final convertedCommand =
                                      AsciiEncoder().convert(command);

                                  // await this.mCharacteristics.write([97, 98]);
                                  await this
                                      .mCharacteristicWrite
                                      .write(convertedCommand);
                            //timer.cancel();
                          });
                        },
                        onPointerUp: (event) {
                          color8 = Colors.white;
                          print("onPointer");
                          timer1.cancel();
                          setState(() {});
                        },
                      ),
                    ),
                    container(
                      width: 80,
                      height: 80,
                      x: 80,
                      colorInside: Colors.transparent,
                      colorBorder: Colors.blue,
                      child: Listener(
                        child: container(
                            colorInside: Colors.transparent,
                            width: 40,
                            height: 40,
                            x: 40,
                            colorBorder: Colors.transparent,
                            child: Icon(
                              Icons.local_hotel,
                              color: color9,
                              size: 40,
                            )),
                        onPointerDown: (event) {
                          color9 = Colors.blue;
                          print("onPointerDown");
                          print(222222);
                          setState(() {});
                          timer1 =
                              Timer.periodic(Duration(seconds: 1), (timer) async{
                            print(222222);
                             final command = "bed bed";
                                  final convertedCommand =
                                      AsciiEncoder().convert(command);

                                  // await this.mCharacteristics.write([97, 98]);
                                  await this
                                      .mCharacteristicWrite
                                      .write(convertedCommand);
                            //timer.cancel();
                          });
                        },
                        onPointerUp: (event) {
                          color9 = Colors.white;
                          print("onPointer");
                          timer1.cancel();
                          setState(() {});
                        },
                      ),
                    ),
                    container(
                      width: 80,
                      height: 80,
                      x: 80,
                      colorInside: Colors.transparent,
                      colorBorder: Colors.blue,
                      child: Listener(
                        child: container(
                            colorInside: Colors.transparent,
                            width: 40,
                            height: 40,
                            x: 40,
                            colorBorder: Colors.transparent,
                            child: Icon(
                              Icons.lightbulb,
                              color: color10,
                              size: 40,
                            )),
                        onPointerDown: (event) {
                          color10 = Colors.blue;
                          print("onPointerDown");
                          print(222222);
                          setState(() {});
                          timer1 =
                              Timer.periodic(Duration(seconds: 1), (timer) async{
                            print(222222);
                             final command =" light light";
                                  final convertedCommand =
                                      AsciiEncoder().convert(command);

                                  // await this.mCharacteristics.write([97, 98]);
                                  await this
                                      .mCharacteristicWrite
                                      .write(convertedCommand);
                            //timer.cancel();
                          });
                        },
                        onPointerUp: (event) {
                          color10 = Colors.white;
                          print("onPointer");
                          timer1.cancel();
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ])),
    );
  }
}
