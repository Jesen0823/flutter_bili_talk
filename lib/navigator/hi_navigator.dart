//记录当前和上次打开得页面
import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/page/favorite_list_page.dart';
import 'package:flutter_bili_talk/page/login_page.dart';
import 'package:flutter_bili_talk/page/notice_page.dart';
import 'package:flutter_bili_talk/page/registration_page.dart';
import 'package:flutter_bili_talk/page/theme_mode_setting.dart';
import 'package:flutter_bili_talk/page/video_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bottom_navigator.dart';

/// 监听页面跳转
/// @param current当前页面， pre上个页面
typedef RouteChangeListener(RouteStatusInfo current, RouteStatusInfo pre);

///创建页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

///获取routeStatus在页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

///定义路由封装 ，路由状态
enum RouteStatus {
  login,
  registration,
  home,
  detail,
  unknown,
  themeSetting,
  notice,
  favoriteList,
}

//获取page对应的RouteStates
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is BottomNavigator) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  } else if (page.child is NoticePage) {
    return RouteStatus.notice;
  } else if (page.child is ThemeModeSetting) {
    return RouteStatus.themeSetting;
  } else if (page.child is FavoriteListPage) {
    return RouteStatus.favoriteList;
  } else {
    return RouteStatus.unknown;
  }
}

//封装路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

///监听路由页面跳转
///感知当前页面是否压后台
class HiNavigator extends _RouteJumpListener {
  static HiNavigator _instance;

  List<RouteChangeListener> _listeners = [];

  // 私有构造方法
  HiNavigator._();

  RouteJumpListener _routeJump;

  RouteStatusInfo _current;
  //首页底部tab
  RouteStatusInfo _bottomTab;

  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }
    return _instance;
  }

  ///注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routeJump = routeJumpListener;
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map args}) {
    print('hi_navigation, routeStatus:$routeStatus, args: $args');
    _routeJump.onJumpTo(routeStatus, args: args);
  }

  ///监听路由页面跳转
  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  //移除监听
  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  /// 监听首页底部 tab切换
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab);
  }

  /// 通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var current =
        RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is BottomNavigator && _bottomTab != null) {
      //如果打开的是首页，则明确到首页具体的tab
      current = _bottomTab;
    }
    print("hi _notify: current：${current.page}");
    print("hi _notify:pre: ${_current?.page}");
    _listeners.forEach((listener) {
      listener(current, _current);
    });
    _current = current;
  }

  RouteStatusInfo getCurrent() {
    return _current;
  }

  Future<void> openH5Url(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<bool> openH5(String url) async {
    var result = await canLaunch(url);
    if (result) {
      return await launch(url);
    } else {
      return Future.value(false);
    }
  }
}

///抽象类提供HiNavigator实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map args});
}

///定义一个类型
typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map args});

///定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  final OnJumpTo onJumpTo;

  RouteJumpListener({this.onJumpTo});
}
