import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/core/hi_base_tab_state.dart';
import 'package:flutter_bili_talk/http/dao/ranking_dao.dart';
import 'package:flutter_bili_talk/model/ranking_model.dart';
import 'package:flutter_bili_talk/model/video_model.dart';
import 'package:flutter_bili_talk/widget/video_small_card.dart';

class RankingTabPage extends StatefulWidget {
  final String sort;

  const RankingTabPage({Key key, @required this.sort}) : super(key: key);

  @override
  _RankingTabPageState createState() => _RankingTabPageState();
}

class _RankingTabPageState
    extends HiBaseTabState<RankingModel, VideoModel, RankingTabPage> {
  @override
  void initState() {
    super.initState();
    print("_RankingTabPageState initState :" + widget.sort.toString());
  }

  @override
  get contentChild => Container(
        child: ListView.builder(
          // 列表未铺满屏幕时禁止上拉加载更多
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 10),
          itemCount: dataList.length,
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) =>
              VideoSmallCard(videoModel: dataList[index]),
        ),
      );

  @override
  Future<RankingModel> getData(int pageIndex) async {
    RankingModel result =
        await RankingDao.get(widget.sort, pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoModel> parseList(result) {
    return result.list;
  }
}
