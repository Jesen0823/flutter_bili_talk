import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/page/ranking_tab_page.dart';
import 'package:flutter_bili_talk/util/view_util.dart';
import 'package:flutter_bili_talk/widget/hi_tab_common.dart';
import 'package:flutter_bili_talk/widget/navigation_bar.dart';

/// 排行榜
class RankingPage extends StatefulWidget {
  const RankingPage({Key key}) : super(key: key);

  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with TickerProviderStateMixin {
  /// 控制器
  TabController _controller;

  /// tab 列表
  static const tabs = [
    {"key": "like", "name": "最热"},
    {"key": "pubdate", "name": "最新"},
    {"key": "favorite", "name": "收藏"}
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  _buildNavigationBar() {
    return NavigationBar(
      child: Container(
        alignment: Alignment.center,
        child: _tabBar(),
        decoration: bottomBoxShadow(),
      ),
    );
  }

  _tabBar() {
    return HiTab(
      tabs.map<Tab>((tab) {
        return Tab(text: tab['name']);
      }).toList(),
      fontSize: 16,
      borderWidth: 3,
      unselectedLabelColor: Colors.black54,
      controller: _controller,
    );
  }

  _buildTabView() {
    return Flexible(
      child: TabBarView(
        controller: _controller,
        children: tabs.map((tab) {
          return RankingTabPage(sort: tab['key']);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            _buildNavigationBar(),
            _buildTabView(),
          ],
        ),
      ),
    );
  }
}
