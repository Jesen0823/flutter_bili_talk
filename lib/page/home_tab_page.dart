import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/model/home_model.dart';
import 'package:flutter_bili_talk/widget/hi_banner.dart';

/// 首页顶部导航
class HomeTabPage extends StatefulWidget {
  final String name;
  final List<BannerMo> bannerList;
  const HomeTabPage({Key key, this.name, this.bannerList}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [if (widget.bannerList != null) _banner()],
      ),
    );
  }

  _banner() {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: HiBanner(widget.bannerList),
    );
  }
}
