import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/barrage/barrage_input.dart';
import 'package:flutter_bili_talk/http/dao/favorite_dao.dart';
import 'package:flutter_bili_talk/http/dao/like_dao.dart';
import 'package:flutter_bili_talk/http/dao/video_detail_dao.dart';
import 'package:flutter_bili_talk/model/video_detail_model.dart';
import 'package:flutter_bili_talk/model/video_model.dart';
import 'package:flutter_bili_talk/provider/theme_provider.dart';
import 'package:flutter_bili_talk/util/hi_contants.dart';
import 'package:flutter_bili_talk/util/view_tool.dart';
import 'package:flutter_bili_talk/widget/app_bar.dart';
import 'package:flutter_bili_talk/widget/barrage_switch.dart';
import 'package:flutter_bili_talk/widget/detail_interaction_bar.dart';
import 'package:flutter_bili_talk/widget/expendable_content.dart';
import 'package:flutter_bili_talk/widget/hi_tab_common.dart';
import 'package:flutter_bili_talk/widget/navigation_bar.dart';
import 'package:flutter_bili_talk/widget/video_header.dart';
import 'package:flutter_bili_talk/widget/video_small_card.dart';
import 'package:flutter_bili_talk/widget/video_view.dart';
import 'package:flutter_overlay/flutter_overlay.dart';
import 'package:hi_barrage/hi_barrage.dart';
import 'package:hi_base/toast.dart';
import 'package:hi_net/core/hi_error.dart';
import 'package:provider/provider.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetailPage(this.videoModel, {Key key}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

// TabController 需要用 TickerProviderStateMixin
class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  List tabs = ['简介', '评论'];

  // 关联视频，视频列表
  List<VideoModel> videoList = [];

  // 详情页数据model
  VideoDetailModel videoDetailModel;
  VideoModel videoModelNew;

  var _barrageKey = GlobalKey<HiBarrageState>();

  // 输入框是否打开
  bool _inputShowing = false;
  var _tabColor;

  @override
  void initState() {
    super.initState();
    // 为Android设置黑色状态栏
    changeStatusBar(color: Colors.black, statusStyle: StatusStyle.LIGHT_STYLE);
    _tabController = TabController(length: tabs.length, vsync: this);

    videoModelNew = widget.videoModel;
    _loadDetailData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
        body: MediaQuery.removePadding(
      removeTop: Platform.isIOS,
      context: context,
      child: videoModelNew.url != null
          ? Column(
              children: [
                NavigationBar(
                  color: Colors.black,
                  statusStyle: StatusStyle.LIGHT_STYLE,
                  height: Platform.isAndroid ? 0 : 46,
                ),
                _buildVideoView(),
                _buildTabNavigation(
                    themeProvider.isDark() ? Colors.black12 : Colors.white),
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
            )
          : Container(),
    ));
  }

  _buildVideoView() {
    var model = videoModelNew;
    return VideoView(model.url,
        cover: model.cover,
        overLayUI: videoAppBar(),
        barrageUI: HiBarrage(
          headers: HiConstants.headers(),
          key: _barrageKey,
          vid: model.vid,
          autoPlay: true,
        ));
  }

  _buildTabNavigation(Color color) {
    // 通过Material组件实现了阴影效果
    return Material(
      elevation: 5,
      shadowColor: Colors.grey[100],
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        height: 39,
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabBar(),
            _buildBarrageBtn(),
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
        ...buildVideoList(),
      ],
    );
  }

  buildContents() {
    return [
      Container(
        child: VideoHeader(
          owner: videoModelNew.owner,
        ),
      ),
      ExpandableContent(
        videoModel: videoModelNew,
      ),
      InteractionToolBar(
        detailModel: videoDetailModel,
        videoModel: videoModelNew,
        onLike: _doLike,
        onUnLike: _doUnLike,
        onFavorite: _doFavorite,
      ),
    ];
  }

  // 数据加载
  void _loadDetailData() async {
    try {
      VideoDetailModel result = await VideoDetailDao.get(videoModelNew.vid);
      print('video detail loadData result: $result');
      setState(() {
        videoDetailModel = result;
        // 将VideoModel更新为详情页接口最新的数据
        videoModelNew = result.videoModel;
        videoList = result.videoList;
      });
    } on NeedAuth catch (e) {
      print('video detail request: $e');
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print('video detail request: $e');
      showWarnToast(e.message);
    }
  }

  /// 点赞
  void _doLike() async {
    try {
      var result =
          await LikeDao.like(videoModelNew.vid, !videoDetailModel.isLike);
      print('support like request result,: $result');
      // 更新点赞状态
      videoDetailModel.isLike = !videoDetailModel.isLike;
      if (videoDetailModel.isLike) {
        videoModelNew.like += 1;
      } else {
        videoModelNew.like -= 1;
      }
      setState(() {
        videoDetailModel = videoDetailModel;
        videoModelNew = videoModelNew;
      });
      showToast(result['msg']);
    } on NeedAuth catch (e) {
      print('like request: $e');
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print('like request: $e');
      showWarnToast(e.message);
    }
  }

  /// 踩
  void _doUnLike() {}

  /// 收藏
  void _doFavorite() async {
    try {
      var result = await FavoriteDao.favorite(
          videoModelNew.vid, !videoDetailModel.isFavorite);
      print('favorite request result,: $result');
      // 更新收藏状态
      videoDetailModel.isFavorite = !videoDetailModel.isFavorite;
      if (videoDetailModel.isFavorite) {
        videoModelNew.favorite += 1;
      } else {
        videoModelNew.favorite -= 1;
      }
      setState(() {
        videoDetailModel = videoDetailModel;
        videoModelNew = videoModelNew;
      });
      showToast(result['msg']);
    } on NeedAuth catch (e) {
      print('favorite request: $e');
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print('favorite request: $e');
      showWarnToast(e.message);
    }
  }

  buildVideoList() {
    return videoList
        .map((VideoModel vm) => VideoSmallCard(videoModel: vm))
        .toList();
  }

  /// 详细页右上角TV按钮
  /// 点击可发送弹幕
  _buildBarrageBtn() {
    return BarrageSwitch(
        inoutShowing: _inputShowing, // 默认是否展示‘输入中’
        onShowInput: () {
          setState(() {
            _inputShowing = true;
          });

          // 弹出输入框
          HiOverlay.show(
            context,
            child: BarrageInput(onTabClose: () {
              setState(() {
                _inputShowing = false;
              });
            }),
          ).then((value) {
            print('input content is : $value');
            // 发送弹幕
            _barrageKey.currentState.send(value);
          });
        },
        // 弹幕播放暂停
        onBarrageSwitch: (open) {
          if (open) {
            _barrageKey.currentState.play();
          } else {
            _barrageKey.currentState.pause();
          }
        });
  }
}
