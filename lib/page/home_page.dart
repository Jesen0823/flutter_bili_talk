import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/model/video_model.dart';
import 'package:flutter_bili_talk/navigator/hi_navigator.dart';

/// 首页

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var listener;

  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      print('current:${current.page}, pre:${pre.page}');
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
      appBar: AppBar(),
      body: Column(
        children: [
          Text('首页'),
          MaterialButton(
            onPressed: () {
              HiNavigator.getInstance().onJumpTo(RouteStatus.detail,
                  args: {'videoMo': VideoModel()});
            },
            child: Text('详情'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(this.listener);
    super.dispose();
  }
}
