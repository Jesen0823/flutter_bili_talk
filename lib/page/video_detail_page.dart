import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/http/core/hi_error.dart';
import 'package:flutter_bili_talk/http/dao/video_detail_dao.dart';
import 'package:flutter_bili_talk/model/video_detail_model.dart';
import 'package:flutter_bili_talk/model/video_model.dart';
import 'package:flutter_bili_talk/util/toast.dart';
import 'package:flutter_bili_talk/util/view_util.dart';
import 'package:flutter_bili_talk/widget/app_bar.dart';
import 'package:flutter_bili_talk/widget/expendable_content.dart';
import 'package:flutter_bili_talk/widget/hi_tab_common.dart';
import 'package:flutter_bili_talk/widget/navigation_bar.dart';
import 'package:flutter_bili_talk/widget/video_header.dart';
import 'package:flutter_bili_talk/widget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetailPage({Key key, this.videoModel}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

// TabController 需要用 TickerProviderStateMixin
class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  List tabs = ['简介', '评论'];

  // 详情页数据model
  VideoDetailModel videoDetailModel;

  @override
  void initState() {
    super.initState();
    // 为Android设置黑色状态栏
    changeStatusBar(color: Colors.black, statusStyle: StatusStyle.LIGHT_STYLE);
    _tabController = TabController(length: tabs.length, vsync: this);
    _loadDetailData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          _buildVideoView(),
          _buildTabNavigation(),
          Flexible(
              child: TabBarView(
            controller: _tabController,
            children: [
              _buildDetailList(),
              Container(
                child: Text('开发中...'),
              ),
            ],
          ))
        ],
      ),
    ));
  }

  _buildVideoView() {
    var model = widget.videoModel;
    return VideoView(
      model.url,
      cover: model.cover,
      overLayUI: videoAppBar(),
    );
  }

  _buildTabNavigation() {
    // 通过Material组件实现了阴影效果
    return Material(
      elevation: 5,
      shadowColor: Colors.grey[100],
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        height: 39,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabBar(),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.live_tv_rounded,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return HiTab(
      tabs
          .map<Tab>((name) => Tab(
                text: name,
              ))
          .toList(),
      controller: _tabController,
    );
  }

  _buildDetailList() {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        ...buildContents(),
        Container(
          height: 500,
          margin: EdgeInsets.only(top: 10),
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(color: Colors.lightBlueAccent),
          child: Text('展开列表'),
        ),
      ],
    );
  }

  buildContents() {
    return [
      Container(
        child: VideoHeader(
          owner: widget.videoModel.owner,
        ),
      ),
      ExpandableContent(
        videoModel: widget.videoModel,
      ),
    ];
  }

  // 数据加载
  void _loadDetailData() async {
    try {
      VideoDetailModel result = await VideoDetailDao.get(widget.videoModel.vid);
      print('video detail loadData result: $result');
      setState(() {
        videoDetailModel = result;
      });
    } on NeedAuth catch (e) {
      print('video detail request: $e');
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print('video detail request: $e');
      showWarnToast(e.message);
    }
  }
}
