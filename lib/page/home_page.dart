import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/http/core/hi_error.dart';
import 'package:flutter_bili_talk/http/dao/home_dao.dart';
import 'package:flutter_bili_talk/model/home_model.dart';
import 'package:flutter_bili_talk/navigator/hi_navigator.dart';
import 'package:flutter_bili_talk/page/home_tab_page.dart';
import 'package:flutter_bili_talk/util/color.dart';
import 'package:flutter_bili_talk/util/toast.dart';
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

  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: categoryList.length, vsync: this);

    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      print('home:current:${current.page}, home:pre:${pre.page}');
      if (widget == current.page || current.page is HomePage) {
        // 当前页面被打开
        print('homePage is opened or onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('homePage is back or onPause');
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
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 30),
              child: _tabBar(),
            ),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: categoryList.map((tab) {
                  return HomeTabPage(
                    name: tab.name,
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
    HiNavigator.getInstance().removeListener(this.listener);
    _tabController.dispose();
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
}
