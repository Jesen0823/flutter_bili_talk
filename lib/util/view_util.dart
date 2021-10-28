import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/navigator/hi_navigator.dart';
import 'package:flutter_bili_talk/page/profile_page.dart';
import 'package:flutter_bili_talk/page/video_detail_page.dart';
import 'package:flutter_bili_talk/provider/theme_provider.dart';
import 'package:flutter_bili_talk/util/color.dart';
import 'package:flutter_bili_talk/widget/navigation_bar.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:provider/provider.dart';

import 'format_util.dart';

/// 带缓存的Image
Widget cachedImage(String url, {double width, double height}) {
  return CachedNetworkImage(
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholder: (BuildContext context, String url) => Container(
            color: Colors.grey[200],
          ),
      errorWidget: (BuildContext context, String url, dynamic error) =>
          Icon(Icons.error),
      imageUrl: url);
}

blackLineGradient({bool fromTop = false}) {
  return LinearGradient(
    begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
    end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
    colors: [
      Colors.black54,
      Colors.black45,
      Colors.black38,
      Colors.black26,
      Colors.black12,
      Colors.transparent,
    ],
  );
}

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
    var page = HiNavigator.getInstance().getCurrent()?.page;
    // 解决Android切换个人中心页面状态栏变白的问题
    if (page is ProfilePage) {
      color = Colors.transparent;
    } else if (page is VideoDetailPage) {
      color = Colors.black;
    }
  }
  //沉浸式状态栏样式
  FlutterStatusbarManager.setColor(color, animated: false);
  FlutterStatusbarManager.setStyle(statusStyle == StatusStyle.DARK_STYLE
      ? StatusBarStyle.DARK_CONTENT
      : StatusBarStyle.LIGHT_CONTENT);
}

///带文字的小图标
smallIconText(IconData iconData, var text) {
  var style = TextStyle(fontSize: 12, color: Colors.grey);
  if (text is int) {
    text = countFormat(text);
  }
  return [
    Icon(
      iconData,
      color: Colors.grey,
      size: 12,
    ),
    Text(
      ' $text',
      style: style,
    )
  ];
}

///border线
borderLine(BuildContext context, {bottom: true, top: false}) {
  BorderSide borderSide = BorderSide(width: 0.5, color: Colors.grey[200]);
  return Border(
    bottom: bottom ? borderSide : BorderSide.none,
    top: top ? borderSide : BorderSide.none,
  );
}

/// 间距封装
SizedBox hiSpace({double height: 1, double width: 1}) {
  return SizedBox(height: height, width: width);
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
