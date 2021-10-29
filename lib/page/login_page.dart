import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/http/dao/login_dao.dart';
import 'package:flutter_bili_talk/navigator/hi_navigator.dart';
import 'package:flutter_bili_talk/util/string_util.dart';
import 'package:flutter_bili_talk/util/toast.dart';
import 'package:flutter_bili_talk/widget/app_bar.dart';
import 'package:flutter_bili_talk/widget/login_button.dart';
import 'package:flutter_bili_talk/widget/login_effect.dart';
import 'package:flutter_bili_talk/widget/login_input.dart';
import 'package:hi_net/core/hi_error.dart';

/// 登录页面

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isProtect = false;
  // 按钮可点状态
  bool loginEnable = false;
  String userName;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('密码登录', '注册', () {
        print('right btn click');
        HiNavigator.getInstance().onJumpTo(RouteStatus.registration);
      }, key: Key('registerKey')),
      body: Container(
        child: ListView(
          // 自适应键盘抬起防止遮挡
          children: [
            LoginEffect(protect: isProtect),
            LoginInput(
              "用户名",
              "请输入用户名",
              onChanged: (text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              "密码",
              "请输入密码",
              lineStrech: true,
              obscureText: true,
              onChanged: (text) {
                password = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  this.isProtect = focus;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: LoginButton(
                '登录',
                enable: loginEnable,
                onPressed: _send,
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void _send() async {
    try {
      var result = await LoginDao.login(userName, password);
      print(result);
      if (result['code'] == 0) {
        print('登录成功');
        showToast('登录成功');
        HiNavigator.getInstance().onJumpTo(RouteStatus.home);
      } else {
        print(result['msg']);
        showToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }
}
