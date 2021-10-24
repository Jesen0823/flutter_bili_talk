import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/model/home_model.dart';

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
      child: Text(widget.name),
    );
  }
}
