import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/util/view_util.dart';

enum StatusStyle { LIGHT_STYLE, DARK_STYLE }

/// 沉浸式导航栏样式

class NavigationBar extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget child;

  const NavigationBar(
      {Key key, this.statusStyle, this.color, this.height, this.child})
      : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  void initState() {
    super.initState();
    _statusBarInit();
  }

  @override
  Widget build(BuildContext context) {
    // 状态栏高度,top为刘海屏刘海高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width, // 屏幕宽度
      height: top + widget.height,
      child: widget.child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: widget.color),
    );
  }

  void _statusBarInit() {
    // 沉浸式状态栏
    changeStatusBar(color: widget.color, statusStyle: widget.statusStyle);
  }
}
