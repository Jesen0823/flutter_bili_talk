import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/db/hi_cache.dart';
import 'package:flutter_bili_talk/http/core/hi_error.dart';
import 'package:flutter_bili_talk/http/core/hi_net.dart';
import 'package:flutter_bili_talk/http/dao/login_dao.dart';
import 'package:flutter_bili_talk/http/request/notice_request.dart';
import 'package:flutter_bili_talk/http/request/test_request.dart';
import 'package:flutter_bili_talk/model/owner.dart';
import 'package:flutter_bili_talk/model/result.dart';
import 'package:flutter_bili_talk/page/registration_page.dart';
import 'package:flutter_bili_talk/util/aes_ecb_encode.dart';
import 'package:flutter_bili_talk/util/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // HiCache预初始化
    HiCache.preInit();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: white,
      ),
      home: RegistrationPage(), // 测试注册页面
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    // 初始化SharePreferences
    HiCache.preInit();
  }

  void _incrementCounter() {
    // 测试
    //test();
    //testjosen();
    //testSharedPrefrerence();
    //testJsonToMap();
    // testNotice();
    //testLogin();
    testAES();

    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void test() async {
    // 测试
    TestRequest request = TestRequest();
    request.add("aa", "aaa").add("bb", "bbbb").add("requestParams", "ppp");
    try {
      var result = await HiNet.getInstance().fire(request);
      print('[Flut] result: $result');
    } on NeedAuth catch (e) {
      print(e);
    } on NeedLogin catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  void testjosen() async {
    var ownerMap = {
      "name": "伊零Qnezero",
      "face":
          "http://i2.hdslb.com/bfs/face/1c57a17a7b077ccd19dba58a981a673799b85aef.jpg",
      "fans'": 0
    };
    Owner owner = Owner.fromJson(ownerMap);
    print(owner.toString());

    // json_serializable的使用
    var result = Result.fromJson(ownerMap);
  }

  void testSharedPrefrerence() {
    HiCache.getInstance().setString('key', '1234');
    var value = HiCache.getInstance().get('key');
    print('quhui: $value');
  }

  void testJsonToMap() {
    const jsonString =
        "{ \"name\": \"flutter\", \"url\": \"https://coding.imooc.com/class/487.html\" }";
    //json 转map
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    print('name:${jsonMap['name']}');
    print('url:${jsonMap['url']}');

    String json = jsonEncode(jsonMap);
    print("json: $json");
  }

  void testNotice() async {
    try {
      var notice = await HiNet.getInstance().fire(NoticeRequest());
      print(notice);
    } on NeedLogin catch (e) {
      print(e);
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e.message);
    }
  }

  Future<void> testLogin() async {
    try {
      var result =
          await LoginDao.registration('kkf', 'pass123', '123445', '5566');
      print('注册：$result');
      var loginRet = await LoginDao.login('kkf', 'pass123');
      print('登录：$loginRet');
    } on NeedLogin catch (e) {
      print(e);
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e.message);
    }
  }

  Future<void> testAES() async {
    var encodeStr = await aesEncode('nmb123');
    print('after encode: $encodeStr');
    var decodeStr = await aesDecode(encodeStr);
    print('after decode: $decodeStr');
  }
}
