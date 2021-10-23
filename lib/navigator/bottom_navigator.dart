import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/page/home_page.dart';
import 'package:flutter_bili_talk/util/color.dart';

import 'hi_navigator.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = primary;
  int _currentIndex = 0;
  static int _initialPage = 0;
  final PageController _controller = PageController(initialPage: 0);
  List<Widget> _pages;
  bool _hasBuild = false;
  @override
  Widget build(BuildContext context) {
    _pages = [
      HomePage(),
    ];

    if (!_hasBuild) {
      //第一次打开时通知打开的是哪个tab
      HiNavigator.getInstance()
          .onBottomTabChange(_initialPage, _pages[_initialPage]);
      _hasBuild = true;
    }
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _pages,
        onPageChanged: (index) => _onJumpTo(index, pageChange: true),
        physics: NeverScrollableScrollPhysics(), //禁止横向滚动
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _onJumpTo(index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _activeColor,
        items: [
          _bottomItem('首页', Icons.home, 0),
          _bottomItem('排行', Icons.local_fire_department, 1),
          _bottomItem('收藏', Icons.favorite, 2),
          _bottomItem('我的', Icons.live_tv, 3),
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor),
      activeIcon: Icon(icon, color: _activeColor),
      label: title,
    );
  }

  _onJumpTo(index, {pageChange = false}) {
    if (!pageChange) {
      //让pageview展示对应的tab
      _controller.jumpToPage(index);
    } else {
      HiNavigator.getInstance().onBottomTabChange(index, _pages[index]);
    }
    setState(() {
      //控制选中第一个tab
      _currentIndex = index;
    });
  }
}

class RankingPage {}
