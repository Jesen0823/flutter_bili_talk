import 'package:flutter/material.dart';

/// 首页顶部导航
class HomeTabPage extends StatefulWidget {
  final String name;
  const HomeTabPage({Key key, this.name}) : super(key: key);

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
