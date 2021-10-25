import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/model/video_model.dart';
import 'package:flutter_bili_talk/widget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetailPage({Key key, this.videoModel}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('详情 vid:${widget.videoModel.vid}'),
          Text('详情 title:${widget.videoModel.title}'),
          _videoView(),
        ],
      ),
    );
  }

  _videoView() {
    var model = widget.videoModel;
    return VideoView(
      model.url,
      cover: model.cover,
    );
  }
}
