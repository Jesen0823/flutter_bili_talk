import 'package:flutter/material.dart';

/// 登录输入动效
class LoginEffect extends StatefulWidget {
  final bool protect; //是否是保护类型,保护密码不让动画小卡通看到

  const LoginEffect({Key key, @required this.protect}) : super(key: key);

  @override
  _LoginEffectState createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border(bottom: BorderSide(color: Colors.grey[300]))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _image(true),
          Image(
            height: 90,
            width: 90,
            image: AssetImage('images/logo.png'),
          ),
          _image(false),
        ],
      ),
    );
  }

  _image(bool isLeft) {
    var headLeft = widget.protect
        ? 'images/head_left_protect.png'
        : 'images/head_left.png';
    var headRight = widget.protect
        ? 'images/head_right_protect.png'
        : "images/head_right.png";
    return Image(
      height: 90,
      image: AssetImage(isLeft ? headLeft : headRight),
    );
  }
}
