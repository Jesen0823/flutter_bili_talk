import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/core/hi_state.dart';
import 'package:flutter_bili_talk/http/core/hi_error.dart';
import 'package:flutter_bili_talk/http/dao/home_dao.dart';
import 'package:flutter_bili_talk/model/home_model.dart';
import 'package:flutter_bili_talk/navigator/hi_navigator.dart';
import 'package:flutter_bili_talk/page/home_tab_page.dart';
import 'package:flutter_bili_talk/page/profile_page.dart';
import 'package:flutter_bili_talk/page/video_detail_page.dart';
import 'package:flutter_bili_talk/util/color.dart';
import 'package:flutter_bili_talk/util/toast.dart';
import 'package:flutter_bili_talk/util/view_util.dart';
import 'package:flutter_bili_talk/widget/navigation_bar.dart';
import 'package:underline_indicator/underline_indicator.dart';

/// 首页

class HomePage extends StatefulWidget {
  final ValueChanged<int> onJumpTo;
  const HomePage({Key key, this.onJumpTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// WidgetsBindingObserver 用来监听生命周期变化
class _HomePageState extends HiState<HomePage>
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  var listener;
  TabController _tabController;

  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];
  bool _isLoading = true;
  // 当前页面
  Widget _currentPage;

  @override
  void initState() {
    super.initState();

    // 生命周期注册
    WidgetsBinding.instance.addObserver(this);

    _tabController = TabController(length: categoryList.length, vsync: this);

    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      this._currentPage = current.page;
      print('home:current:${current.page}, home:pre:${pre.page}');
      if (widget == current.page || current.page is HomePage) {
        // 当前页面被打开
        print('homePage is opened or onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('homePage is back or onPause');
      }

      // 当页面返回到首页恢复首页的状态栏样式
      if (pre?.page is VideoDetailPage && !(current.page is ProfilePage)) {
        var statusStyle = StatusStyle.DARK_STYLE;
        changeStatusBar(color: Colors.white, statusStyle: statusStyle);
      }
    });

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            NavigationBar(
              height: 50,
              child: _appBar(),
              color: Colors.white,
              statusStyle: StatusStyle.DARK_STYLE,
            ),
            Container(
              color: Colors.white,
              child: _tabBar(),
            ),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: categoryList.map((tab) {
                  return HomeTabPage(
                    categoryName: tab.name,
                    // 只在推荐页面展示banner
                    bannerList: tab.name == '推荐' ? bannerList : null,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    HiNavigator.getInstance().removeListener(this.listener);
    _tabController.dispose();
    super.dispose();
  }

  // 监听生命周期的变化
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('[Flut] didChangeAppLifecycleState, state: $state');
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停
        break;
      case AppLifecycleState.resumed: //从后台切换前台，界面可见
        // fixBug, 后台切到前台状态栏颜色发生变化问题
        if (!(_currentPage is VideoDetailPage)) {
          changeStatusBar(
              color: Colors.white, statusStyle: StatusStyle.DARK_STYLE);
        }
        break;
      case AppLifecycleState.paused: //界面不可见,后台
        break;
      case AppLifecycleState.detached: //APP结束时调用
        break;
    }
  }

  /// 用来设置 当tab页面发生变化时不会创建多次
  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return TabBar(
        controller: _tabController,
        isScrollable: true, // 顶部TabBar是否可以滚动
        labelColor: Colors.black,
        indicator: UnderlineIndicator(
            strokeCap: StrokeCap.round,
            borderSide: BorderSide(color: primary, width: 3),
            insets: EdgeInsets.only(left: 15, right: 15)),
        tabs: categoryList.map<Tab>((tab) {
          return Tab(
            child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Text(
                tab.name,
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        }).toList());
  }

  void loadData() async {
    try {
      HomeMo result = await HomeDao.get('推荐');
      print('loadData: $result');
      if (result.categoryList != null) {
        // tab 长度变化后需要重新创建TabController
        _tabController =
            TabController(length: result.categoryList.length, vsync: this);
      }
      setState(() {
        categoryList = result.categoryList;
        bannerList = result.bannerList;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.onJumpTo != null) {
                widget.onJumpTo(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image(
                height: 46,
                width: 46,
                image: AssetImage('images/avatar.png'),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 32,
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                decoration: BoxDecoration(color: Colors.grey[100]),
              ),
            ),
          )),
          Icon(
            Icons.explore_outlined,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(
              Icons.mail_outline,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
