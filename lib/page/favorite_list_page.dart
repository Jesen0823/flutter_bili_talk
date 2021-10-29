import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/core/hi_base_tab_state.dart';
import 'package:flutter_bili_talk/http/dao/favorite_dao.dart';
import 'package:flutter_bili_talk/model/ranking_model.dart';
import 'package:flutter_bili_talk/model/video_model.dart';
import 'package:flutter_bili_talk/navigator/hi_navigator.dart';
import 'package:flutter_bili_talk/page/video_detail_page.dart';
import 'package:flutter_bili_talk/util/view_util.dart';
import 'package:flutter_bili_talk/widget/navigation_bar.dart';
import 'package:flutter_bili_talk/widget/video_small_card.dart';

///收藏列表页面
class FavoriteListPage extends StatefulWidget {
  const FavoriteListPage({Key key}) : super(key: key);

  @override
  _FavoriteListPageState createState() => _FavoriteListPageState();
}

class _FavoriteListPageState
    extends HiBaseTabState<RankingModel, VideoModel, FavoriteListPage> {
  RouteChangeListener listener;

  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      if (pre?.page is VideoDetailPage && current.page is FavoriteListPage) {
        loadData();
      }
    });
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(this.listener);
    super.dispose();
  }

  @override
  get contentChild => ListView.builder(
        padding: EdgeInsets.only(top: 10),
        itemCount: dataList.length,
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => VideoSmallCard(
          videoModel: dataList[index],
        ),
      );

  @override
  Future<RankingModel> getData(int pageIndex) async {
    RankingModel result =
        await FavoriteDao.favoriteList(pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoModel> parseList(RankingModel result) {
    return result.list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNavigationBar(),
        Expanded(child: super.build(context)),
      ],
    );
  }

  _buildNavigationBar() {
    return NavigationBar(
      child: Container(
        decoration: bottomBoxShadow(context),
        alignment: Alignment.center,
        child: Text(
          '收藏',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
