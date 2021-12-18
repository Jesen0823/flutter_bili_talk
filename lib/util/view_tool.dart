import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/navigator/hi_navigator.dart';
import 'package:flutter_bili_talk/page/profile_page.dart';
import 'package:flutter_bili_talk/page/video_detail_page.dart';
import 'package:flutter_bili_talk/provider/theme_provider.dart';
import 'package:flutter_bili_talk/widget/navigation_bar.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:hi_base/color.dart';
import 'package:provider/provider.dart';

///修改状态栏
void changeStatusBar(
    {BuildContext context,
    color: Colors.black,
    StatusStyle statusStyle: StatusStyle.DARK_STYLE}) {
  if (context != null) {
    var themeProvider = context.watch<ThemeProvider>();
    if (themeProvider.isDark()) {
      statusStyle = StatusStyle.LIGHT_STYLE;
      color = HiColor.dark_bg;
    }
  }
  var page = HiNavigator.getInstance().getCurrent()?.page;
  // 解决Android切换个人中心页面状态栏变白的问题
  if (page is ProfilePage) {
    color = Colors.transparent;
  } else if (page is VideoDetailPage) {
    color = Colors.black;
    statusStyle = StatusStyle.LIGHT_STYLE;
  }
  //沉浸式状态栏样式
  FlutterStatusbarManager.setColor(color, animated: false);
  FlutterStatusbarManager.setStyle(statusStyle == StatusStyle.DARK_STYLE
      ? StatusBarStyle.DARK_CONTENT
      : StatusBarStyle.LIGHT_CONTENT);
}

/// 底部阴影
BoxDecoration bottomBoxShadow(BuildContext context) {
  // 主题色适配
  var themeProvider = context.watch<ThemeProvider>();
  if (themeProvider.isDark()) {
    return null;
  }
  return BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey[100],
        offset: Offset(0, 5), //xy轴偏移
        blurRadius: 5, //阴影模糊程度
        spreadRadius: 1, //阴影扩散程度
      )
    ],
  );
}

void showCupertinoAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("这是一个iOS风格的对话框"),
          content: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Align(
                child: Text("这是消息"),
                alignment: Alignment(0, 0),
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("取消"),
              onPressed: () {
                Navigator.pop(context);
                print("取消");
              },
            ),
            CupertinoDialogAction(
              child: Text("确定"),
              onPressed: () {
                print("确定");
              },
            ),
          ],
        );
      });
}

/// 自动登录Dialog
Future alertDialogAutoLogin(
    BuildContext context,
    String title,
    String content,
    String negativeText,
    String cancelText,
    Function onNegativeCallback,
    Function onCancelCallback) {
  var result = showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          backgroundColor: primary[10],
          elevation: 24,
          contentPadding: EdgeInsets.all(18.0),
          buttonPadding:
              EdgeInsets.only(top: 4.0, bottom: 8.0, right: 8.0, left: 8.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          actions: <Widget>[
            TextButton(
              child: Text(cancelText),
              onPressed: () {
                Navigator.of(context).pop(false);
                onCancelCallback();
              },
            ),
            TextButton(
              child: Text(negativeText),
              onPressed: () {
                Navigator.of(context).pop(true);
                onNegativeCallback();
              },
            ),
          ],
        );
      },
      barrierDismissible: true);
  return result;
}
