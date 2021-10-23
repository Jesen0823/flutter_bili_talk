import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/http/core/hi_error.dart';
import 'package:flutter_bili_talk/http/dao/login_dao.dart';
import 'package:flutter_bili_talk/util/string_util.dart';
import 'package:flutter_bili_talk/util/toast.dart';
import 'package:flutter_bili_talk/widget/app_bar.dart';
import 'package:flutter_bili_talk/widget/login_button.dart';
import 'package:flutter_bili_talk/widget/login_effect.dart';
import 'package:flutter_bili_talk/widget/login_input.dart';

/// 注册页面

class RegistrationPage extends StatefulWidget {
  final VoidCallback onJumpToLogin;

  const RegistrationPage({Key key, this.onJumpToLogin}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool isProtect = false;

  // 按钮可点状态
  bool loginEnable = false;
  String userName;
  String password;

  // 重新输入密码确认
  String rePassword;
  String imoocId;
  String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('注册', '登录', widget.onJumpToLogin),
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
                  isProtect = focus;
                });
              },
            ),
            LoginInput(
              "确认密码",
              "请再次输入密码",
              obscureText: true,
              onChanged: (text) {
                rePassword = text;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  isProtect = focus;
                });
              },
            ),
            LoginInput(
              "慕课网ID",
              "请输入慕课网用户ID",
              keybordType: TextInputType.number,
              onChanged: (text) {
                imoocId = text;
                checkInput();
              },
            ),
            LoginInput(
              "订单号",
              "请输入服务订单号后四位",
              keybordType: TextInputType.number,
              lineStrech: true,
              onChanged: (text) {
                orderId = text;
                checkInput();
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton(
                '注册',
                enable: loginEnable,
                onPressed: checkParams,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loginButton() {
    return InkWell(
      onTap: () {
        if (loginEnable) {
          checkParams();
        } else {
          print('_loginButton is false');
        }
      },
      child: Text('注册'),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void checkParams() {
    String tips;
    if (password != rePassword) {
      tips = '两次密码不一致';
    } else if (orderId.length != 4) {
      tips = '请输入订单号的后四位';
    }
    if (tips != null) {
      print(tips);
      return;
    }
    send();
  }

  void send() async {
    try {
      var result =
          await LoginDao.registration(userName, password, imoocId, orderId);
      print(result);
      if (result['code'] == 0) {
        print('注册成功');
        showToast('注册成功');
      } else {
        print(result['msg']);
        showToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
    }
  }
}
