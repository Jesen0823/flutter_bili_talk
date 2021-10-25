import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/model/video_model.dart';
import 'package:flutter_bili_talk/util/view_util.dart';
import 'package:flutter_bili_talk/widget/app_bar.dart';
import 'package:flutter_bili_talk/widget/navigation_bar.dart';
import 'package:flutter_bili_talk/widget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetailPage({Key key, this.videoModel}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  void initState() {
    super.initState();
    // 为Android设置黑色状态栏
    changeStatusBar(color: Colors.black, statusStyle: StatusStyle.LIGHT_STYLE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MediaQuery.removePadding(
      removeTop: Platform.isIOS,
      context: context,
      child: Column(
        children: [
          NavigationBar(
            color: Colors.black,
            statusStyle: StatusStyle.LIGHT_STYLE,
            height: Platform.isAndroid ? 0 : 46,
          ),
          _videoView(),
          Text('详情 vid:${widget.videoModel.vid}'),
          Text('详情 title:${widget.videoModel.title}'),
        ],
      ),
    ));
  }

  _videoView() {
    var model = widget.videoModel;
    return VideoView(
      model.url,
      cover: model.cover,
      overLayUI: videoAppBar(),
    );
  }
}
