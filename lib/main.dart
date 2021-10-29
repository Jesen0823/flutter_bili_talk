import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/db/hi_cache.dart';
import 'package:flutter_bili_talk/http/dao/login_dao.dart';
import 'package:flutter_bili_talk/page/favorite_list_page.dart';
import 'package:flutter_bili_talk/page/login_page.dart';
import 'package:flutter_bili_talk/page/notice_page.dart';
import 'package:flutter_bili_talk/page/registration_page.dart';
import 'package:flutter_bili_talk/page/theme_mode_setting.dart';
import 'package:flutter_bili_talk/page/video_detail_page.dart';
import 'package:flutter_bili_talk/provider/hi_provider.dart';
import 'package:flutter_bili_talk/provider/theme_provider.dart';
import 'package:hi_base/toast.dart';
import 'package:provider/provider.dart';

import 'model/video_model.dart';
import 'navigator/bottom_navigator.dart';
import 'navigator/hi_navigator.dart';

void main() {
  runApp(BiliApp());

  ///应用程序的异常捕获
  /*runZonedGuarded((){
    runApp(BiliApp());
  }, (e, s) => print(e));*/

  /// 或者
  //HiDefend().run(BiliApp());
}

class BiliApp extends StatefulWidget {
  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouteDelegate _routeDelegate = BiliRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache>(
      //打开页面之前 预初始化
      future: HiCache.preInit(),
      builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
        //定义route           加载结束 返回router  否则返回加载中
        var widget = snapshot.connectionState == ConnectionState.done
            ? Router(routerDelegate: _routeDelegate)
            : Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );

        // 主题相关provider
        return MultiProvider(
          providers: topProviders,
          child: Consumer<ThemeProvider>(
            builder: (BuildContext context, ThemeProvider themeProvider,
                Widget child) {
              return MaterialApp(
                home: widget,
                theme: themeProvider.getTheme(),
                darkTheme: themeProvider.getTheme(isDarkMode: true),
                themeMode: themeProvider.getThemeMode(),
                title: 'flutterBili视频',
              );
            },
          ),
        );
      },
    );
  }
}

///代理
class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  // 为 Navigator 设置一个 key，必要时可以通过navigatorKey.currentState 来获取到 navigatorState 对象
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    // 实现路由跳转逻辑
    HiNavigator.getInstance().registerRouteJump(
      RouteJumpListener(
        onJumpTo: (RouteStatus routeStatus, {Map args}) {
          _routeStatus = routeStatus;
          if (routeStatus == RouteStatus.detail) {
            this.videoModel = args['videoModel'];
          }
          notifyListeners();
        },
      ),
    );
  }

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];

  /// 详情视频信息
  VideoModel videoModel;

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else {
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      // 要打开的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      // tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      // 跳转首页时将栈中其它页面进行出栈，因为首页不可回退
      pages.clear();
      page = pageWrap(BottomNavigator());
    } else if (routeStatus == RouteStatus.themeSetting) {
      page = pageWrap(ThemeModeSetting());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage());
    } else if (routeStatus == RouteStatus.notice) {
      page = pageWrap(NoticePage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    } else if (routeStatus == RouteStatus.favoriteList) {
      page = pageWrap(FavoriteListPage());
    }
    // 重新创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages = [...tempPages, page];
    // 通知路由发生变化
    HiNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;

    return WillPopScope(
      // fix Android物理返回键，无法返回上一页问题@https://github.com/flutter/flutter/issues/66349
      onWillPop: () async =>
          !(await navigatorKey.currentState?.maybePop() ?? false),
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          if (route.settings is MaterialPage) {
            // 登录页未登录返回拦截
            if ((route.settings as MaterialPage).child is LoginPage) {
              if (!hasLogin) {
                showWarnToast("请先登录");
                return false;
              }
            }
          }
          // 执行返回操作
          if (!route.didPop(result)) {
            return false;
          }
          var tempPages = [...pages];
          pages.removeLast();
          // 通知路由发生变化
          HiNavigator.getInstance().notify(pages, tempPages);
          return true;
        },
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath path) async {}
}

///可缺省 主要应用与web，持有RouteInfomationProvider 提供的RouteInformation 可以将其解析成我们定义的数据类型
// class BiliRouteInformationParser extends RouteInformationParser<BiliRoutePath> {
//   @override
//   Future<BiliRoutePath> parseRouteInformation(
//       RouteInformation routeInformation) async {
//     final uri = Uri.parse(routeInformation.location);
//     print("uri:$uri");
//     if (uri.pathSegments.length == 0) {
//       return BiliRoutePath.home();
//     } else {
//       return BiliRoutePath.detail();
//     }
//   }
// }

///定义路由数据、path
class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";

  BiliRoutePath.detail() : location = "/detail";
}
