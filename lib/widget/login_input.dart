import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/util/color.dart';

/// 登录输入框 自定义Widget

class LoginInput extends StatefulWidget {
  final String title;
  final String hint;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool> focusChanged;
  final bool lineStrech;
  final bool obscureText;
  final TextInputType keybordType;

  const LoginInput(this.title, this.hint,
      {Key key,
      this.onChanged,
      this.focusChanged,
      this.lineStrech = false,
      this.obscureText = false, // 默认不是密码输入
      this.keybordType}) // 输入框类型/键盘类型
      : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // 监听光标
    _focusNode.addListener(() {
      print('Has focus: ${_focusNode.hasFocus}');
      if (widget.focusChanged != null) {
        widget.focusChanged(_focusNode.hasFocus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
            _input()
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: !widget.lineStrech ? 15 : 0),
          child: Divider(
            height: 1,
            thickness: 0.5,
          ),
        )
      ],
    );
  }

  _input() {
    return Expanded(
      child: TextField(
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        keyboardType: widget.keybordType,
        autofocus: !widget.obscureText, // 非密码样式
        cursorColor: primary, // 光标颜色
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        // 输入框样式
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20, right: 20),
            border: InputBorder.none,
            hintText: widget.hint ?? '',
            hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
