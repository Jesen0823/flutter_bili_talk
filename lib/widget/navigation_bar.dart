import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

enum StatusStyle { LIGHT_STYLE, DARK_STYLE }

/// 沉浸式导航栏样式

class NavigationBar extends StatelessWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget child;

  const NavigationBar(
      {Key key,
      this.statusStyle = StatusStyle.DARK_STYLE,
      this.color = Colors.white,
      this.height = 46,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _statusBarInit();
    // 状态栏高度,top为刘海屏刘海高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width, // 屏幕宽度
      height: top + height,
      child: child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: color),
    );
  }

  void _statusBarInit() {
    // 沉浸式状态栏样式
    FlutterStatusbarManager.setColor(color, animated: false);
    FlutterStatusbarManager.setStyle(statusStyle == StatusStyle.DARK_STYLE
        ? StatusBarStyle.DARK_CONTENT
        : StatusBarStyle.LIGHT_CONTENT);
  }
}
