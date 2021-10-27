import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/util/color.dart';
import 'package:flutter_bili_talk/util/view_util.dart';

/// 弹幕输入
class BarrageInput extends StatelessWidget {
  final VoidCallback onTabClose;

  const BarrageInput({Key key, @required this.onTabClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();
    return Scaffold(
      // 透明背景
      backgroundColor: Colors.transparent,
      body: Column(
        // 键盘上的空白区域
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              if (onTabClose != null) {
                onTabClose();
              }
            },
            child: Container(
              color: Colors.transparent,
            ),
          )),
          SafeArea(
              child: Container(
            color: Colors.white,
            child: Row(
              children: [
                hiSpace(width: 15),
                _buildInput(editingController, context),
                _buildSendBtn(editingController, context),
              ],
            ),
          ))
        ],
      ),
    );
  }

  /// 弹幕输入框
  _buildInput(TextEditingController editingController, BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      child: TextField(
        autofocus: true,
        controller: editingController,
        onSubmitted: (value) {
          _send(value, context);
        },
        cursorColor: primary,
        decoration: InputDecoration(
            isDense: true,
            contentPadding:
                EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
            hintText: '快来发送弹幕参与互动吧'),
      ),
    ));
  }

  /// 发送弹幕
  void _send(String value, BuildContext context) {
    if (value.isNotEmpty) {
      if (onTabClose != null) onTabClose();
      Navigator.pop(context, value);
    }
  }

  _buildSendBtn(TextEditingController editingController, BuildContext context) {
    return InkWell(
      onTap: () {
        var text = editingController.text?.trim() ?? "";
        _send(text, context);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Icon(
          Icons.send_rounded,
          color: Colors.grey,
        ),
      ),
    );
  }
}
