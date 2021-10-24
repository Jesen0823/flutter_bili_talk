import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/model/home_model.dart';
import 'package:flutter_bili_talk/widget/hi_banner.dart';

/// 首页顶部导航
class HomeTabPage extends StatefulWidget {
  // Category类别名称
  final String categoryName;
  final List<BannerMo> bannerList;
  const HomeTabPage({Key key, this.categoryName, this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        // 移除顶部间距
        removeTop: true,
        context: context,
        child: ListView(
          children: [if (widget.bannerList != null) _banner()],
        ));
  }

  _banner() {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: HiBanner(widget.bannerList),
    );
  }
}
