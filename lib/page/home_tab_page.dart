import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/core/hi_base_tab_state.dart';
import 'package:flutter_bili_talk/http/dao/home_dao.dart';
import 'package:flutter_bili_talk/model/home_model.dart';
import 'package:flutter_bili_talk/model/video_model.dart';
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

class _HomeTabPageState
    extends HiBaseTabState<HomeMo, VideoModel, HomeTabPage> {
  @override
  void initState() {
    super.initState();
    print('[Flut] home categoryName: ${widget.categoryName}');
    print('[Flut] home bannerList: ${widget.bannerList}');
  }

  _banner() {
    /*return Padding(
      padding: EdgeInsets.only(left: 5, right: 8),
      child: HiBanner(widget.bannerList),
    );*/

    // banner之间添加间距
    return HiBanner(widget.bannerList,
        padding: EdgeInsets.only(left: 5, right: 5));
  }

  @override
  // wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  get contentChild => StaggeredGridView.countBuilder(
      controller: scrollController,
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      crossAxisCount: 2,
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        //有banner时第一个item位置显示banner
        if (widget.bannerList != null && index == 0) {
          return Padding(padding: EdgeInsets.only(bottom: 8), child: _banner());
        } else {
          return VideoCard(
            videoModel: dataList[index],
          );
        }
      },
      staggeredTileBuilder: (int index) {
        if (widget.bannerList != null && index == 0) {
          return StaggeredTile.fit(2);
        } else {
          return StaggeredTile.fit(1);
        }
      });

  @override
  Future<HomeMo> getData(int pageIndex) async {
    HomeMo result = await HomeDao.get(widget.categoryName,
        pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoModel> parseList(HomeMo result) {
    return result.videoList;
  }
}
