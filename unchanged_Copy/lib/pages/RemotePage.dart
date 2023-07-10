import 'package:flutter/material.dart';
import "dart:async";

class RemotePage extends StatefulWidget {
  //Flutter2.2.0之后需要注意把Key改为可空类型  {Key? key} 表示Key为可空类型
  RemotePage({Key? key}) : super(key: key);

  _RemotePageState createState() => _RemotePageState();
}

class _RemotePageState extends State<RemotePage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 38, 37, 37),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 55, 54, 54),
          title: Text('RemotePage')),
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
                              onPointerDown: (event) {
                                color1 = Colors.blue;
                                print("onPointerDown");
                                print(222222);
                                setState(() {});
                                timer1 = Timer.periodic(Duration(seconds: 1),
                                    (timer) {
                                  print(222222);
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
                                    (timer) {
                                  print(222222);
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
                                    (timer) {
                                  print(222222);
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
                                    (timer) {
                                  print(222222);
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
                                    (timer) {
                                  print(222222);
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
                                    (timer) {
                                  print(222222);
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
                                    (timer) {
                                  print(222222);
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
                                timer1 = Timer.periodic(Duration(seconds: 1),
                                    (timer) {
                                  print(222222);
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
                                timer1 = Timer.periodic(Duration(seconds: 1),
                                    (timer) {
                                  print(222222);
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
                                timer1 = Timer.periodic(Duration(seconds: 1),
                                    (timer) {
                                  print(222222);
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
