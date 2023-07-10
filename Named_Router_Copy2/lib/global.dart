import 'package:flutter/material.dart';
class Global{
  static var xaaa = 0;
  static void set(int x){
    xaaa = x;
  }
  static int get(){
    return xaaa;
  }
}

