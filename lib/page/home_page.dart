import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/model/video_model.dart';

/// 首页

class HomePage extends StatefulWidget {
  final ValueChanged<VideoModel> onJumpDetail;
  const HomePage({Key key, this.onJumpDetail}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('首页'),
          MaterialButton(
            onPressed: () => widget.onJumpDetail,
            child: Text('详情'),
          )
        ],
      ),
    );
  }
}
