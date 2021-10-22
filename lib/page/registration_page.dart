import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/widget/app_bar.dart';
import 'package:flutter_bili_talk/widget/login_effect.dart';
import 'package:flutter_bili_talk/widget/login_input.dart';

/// 注册页面

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool isProtect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('注册', '登录', () {
        print('right btn click');
      }),
      body: Container(
        child: ListView(
          // 自适应键盘抬起防止遮挡
          children: [
            LoginEffect(protect: isProtect),
            LoginInput(
              "用户名",
              "请输入用户名",
              onChanged: (text) {},
            ),
            LoginInput(
              "密码",
              "请输入密码",
              lineStrech: true,
              obscureText: true,
              onChanged: (text) {},
              focusChanged: (focus) {
                setState(() {
                  isProtect = focus;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
