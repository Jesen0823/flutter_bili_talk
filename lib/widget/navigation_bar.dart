import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/provider/theme_provider.dart';
import 'package:flutter_bili_talk/util/view_tool.dart';
import 'package:hi_base/color.dart';
import 'package:provider/provider.dart';

enum StatusStyle { LIGHT_STYLE, DARK_STYLE }

/// 沉浸式导航栏样式

class NavigationBar extends StatefulWidget {
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
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  var _statusStyle;
  var _color;

  @override
  Widget build(BuildContext context) {
    // 主题色适配
    var themeProvider = context.watch<ThemeProvider>();
    if (themeProvider.isDark()) {
      _color = HiColor.dark_bg;
      _statusStyle = StatusStyle.LIGHT_STYLE;
    } else {
      _color = widget.color;
      _statusStyle = widget.statusStyle;
    }
    _statusBarInit();

    // 状态栏高度,top为刘海屏刘海高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width, // 屏幕宽度
      height: top + widget.height,
      child: widget.child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: _color),
    );
  }

  void _statusBarInit() {
    // 沉浸式状态栏
    changeStatusBar(color: _color, statusStyle: _statusStyle);
  }
}
