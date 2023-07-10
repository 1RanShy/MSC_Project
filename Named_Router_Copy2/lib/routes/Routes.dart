import 'package:flutter/material.dart';

import '../pages/Tabs.dart';
import '../pages/Form.dart';
import '../pages/Search.dart';
import '../pages/Product.dart';
import '../pages/ProductInfo.dart';

import '../pages/user/Login.dart';
import '../pages/user/RegisterFirst.dart';
import '../pages/user/RegisterSecond.dart';
import '../pages/user/RegisterThird.dart';
import '../pages/Pdf.dart';
import '../pages/Blue.dart';
import '../pages/Blue2.dart';
import '../pages/Blue3.dart';
import '../pages/RemotePage.dart';
import '../pages/tabs/Home.dart';

//配置路由,定义Map类型的routes,Key为String类型，value为Function类型
final Map<String, Function> routes = {
  '/': (context) => Tabs(),
  '/form': (context) => FormPage(),
  '/home': (context) => HomePage(),
  '/product': (context) => ProductPage(),
  '/productinfo': (context, {arguments}) =>
      ProductInfoPage(arguments: arguments),
  '/search': (context, {arguments}) => SearchPage(arguments: arguments),
  '/login': (context) => LoginPage(),
  '/registerFirst': (context) => RegisterFirstPage(),
  '/registerSecond': (context) => RegisterSecondPage(),
  '/registerThird': (context) => RegisterThirdPage(),
  '/blue': (context, {arguments}) => BluePage(arguments: arguments),
  '/blue2': (context, {arguments}) => BluePage2(arguments: arguments),
  '/blue3': (context, {arguments}) => BluePage3(arguments: arguments),
  '/remotePage': (context) => RemotePage(),
  '/pdf': (context) => MyHomePage(
        title: '',
      ),
};

//固定写法  路由统一处理方法
var onGenerateRoute = (RouteSettings settings) {
  //String? 表示name为可空类型
  final String? name = settings.name;
  //Function? 表示pageContentBuilder为可空类型
  final Function? pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
