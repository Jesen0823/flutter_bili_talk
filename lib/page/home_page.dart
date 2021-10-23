import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/navigator/hi_navigator.dart';
import 'package:flutter_bili_talk/page/home_tab_page.dart';
import 'package:flutter_bili_talk/util/color.dart';
import 'package:underline_indicator/underline_indicator.dart';

/// 首页

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;
  TabController _tabController;
  var tabs = ["推荐", "热门", "追播", "影视", "搞笑", "日常", "综合", "手机游戏", "短片·手书·配音"];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: tabs.length, vsync: this);

    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      print('home:current:${current.page}, home:pre:${pre.page}');
      if (widget == current.page || current.page is HomePage) {
        // 当前页面被打开
        print('homePage is opened or onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('homePage is back or onPause');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 30),
              child: _tabBar(),
            ),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: tabs.map((tab) {
                  return HomeTabPage(
                    name: tab,
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
    HiNavigator.getInstance().removeListener(this.listener);
    super.dispose();
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
        tabs: tabs.map<Tab>((tab) {
          return Tab(
            child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Text(
                tab,
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        }).toList());
  }
}
