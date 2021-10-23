import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/db/hi_cache.dart';
import 'package:flutter_bili_talk/http/dao/login_dao.dart';
import 'package:flutter_bili_talk/page/login_page.dart';
import 'package:flutter_bili_talk/page/registration_page.dart';
import 'package:flutter_bili_talk/page/video_detail_page.dart';
import 'package:flutter_bili_talk/util/color.dart';
import 'package:flutter_bili_talk/util/toast.dart';

import 'model/video_model.dart';
import 'navigator/bottom_navigator.dart';
import 'navigator/hi_navigator.dart';

void main() {
  runApp(BiliApp());
}

class BiliApp extends StatefulWidget {
  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouteDelegate _routeDelegate = BiliRouteDelegate();

  // BiliRouteInformationParser _routeInformationParser =
  //     BiliRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache>(
      //打开页面之前 预初始化
      future: HiCache.preInit(),
      builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
        //定义route           加载结束 返回router  否则返回加载中
        var widget = snapshot.connectionState == ConnectionState.done
            ? Router(
                // routeInformationParser: _routeInformationParser,
                routerDelegate: _routeDelegate,
                //routeInformationParser 为null 时可以缺省，否则必须成对出现， routeInfomation提供者
                // routeInformationProvider: PlatformRouteInformationProvider(
                //     initialRouteInformation: RouteInformation(location: "/")),
              )
            : Scaffold(
                body: Center(
                child: CircularProgressIndicator(),
              ));

        return MaterialApp(
          home: widget,
          theme: ThemeData(primarySwatch: white),
        );
      },
    );
  }
}

///代理
class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //实现路由跳转逻辑
    HiNavigator.getInstance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map args}) {
      _routeStatus = routeStatus;
      if (_routeStatus == RouteStatus.detail) {
        this.videoModel = args['videoMo'];
      }
      notifyListeners();
    }));
  }

  RouteStatus _routeStatus = RouteStatus.home;

  ///定义集合存放页面
  List<MaterialPage> pages = [];
  VideoModel videoModel;

  // BiliRoutePath path;

  ///返回路由堆栈信息
  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);

    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      //跳转首页时将栈中其他页面进行出栈， 因为主页不可回退
      pages.clear();
      page = pageWrap(BottomNavigator());
    } else if (routeStatus == RouteStatus.detail) {
      if (videoModel != null)
        page = pageWrap(VideoDetailPage(
          videoModel: videoModel,
        ));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }

    //创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages = [...tempPages, page];

    //通知路由发生变化
    HiNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;

    return WillPopScope(
      //fix android 物理返回键，无法返回上一页的问题 https://github.com/flutter/flutter/issues/66349
      onWillPop: () async => !await navigatorKey.currentState.maybePop(),
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          if (route.settings is MaterialPage) {
            //登陆页未登陆返回拦截
            if ((route.settings as MaterialPage).child is LoginPage) {
              if (!hasLogin) {
                print('请先登陆');
                showWarnToast('请先登录');
                return false;
              }
            }
          }
          //执行返回操作
          if (!route.didPop(result)) {
            return false;
          }

          var tempePages = [...pages];
          pages.removeLast(); //页面出栈
          //通知路由发生变化
          HiNavigator.getInstance().notify(pages, tempePages);
          return true;
        },
      ),
    );
  }

  // 拦截页面
  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      // 未登录且不是注册页面，则跳转登录
      return _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      // 不做拦截
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Future<void> setNewRoutePath(BiliRoutePath path) async {
    // this.path = path;
  }
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
