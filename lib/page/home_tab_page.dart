import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/http/core/hi_error.dart';
import 'package:flutter_bili_talk/http/dao/home_dao.dart';
import 'package:flutter_bili_talk/model/home_model.dart';
import 'package:flutter_bili_talk/model/video_model.dart';
import 'package:flutter_bili_talk/util/toast.dart';
import 'package:flutter_bili_talk/widget/hi_banner.dart';
import 'package:flutter_bili_talk/widget/video_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
  List<VideoModel> videoList = [];
  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        // 移除顶部间距
        removeTop: true,
        context: context,
        child: StaggeredGridView.countBuilder(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            crossAxisCount: 2,
            itemCount: videoList.length,
            itemBuilder: (BuildContext context, int index) {
              //有banner时第一个item位置显示banner
              if (widget.bannerList != null && index == 0) {
                return Padding(
                    padding: EdgeInsets.only(bottom: 8), child: _banner());
              } else {
                return VideoCard(
                  videoModel: videoList[index],
                );
              }
            },
            staggeredTileBuilder: (int index) {
              if (widget.bannerList != null && index == 0) {
                return StaggeredTile.fit(2);
              } else {
                return StaggeredTile.fit(1);
              }
            }));
  }

  _banner() {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 8),
      child: HiBanner(widget.bannerList),
    );
  }

  void _loadData({loadMore = false}) async {
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    try {
      HomeMo result = await HomeDao.get(widget.categoryName,
          pageIndex: currentIndex, pageSize: 50);
      print('lHome oadData: $result');
      setState(() {
        if (loadMore) {
          // 合并新的数据
          videoList = [...videoList, ...result.videoList];
          if (result.videoList.isNotEmpty) {
            pageIndex++;
          }
        } else {
          videoList = result.videoList;
        }
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }
}
