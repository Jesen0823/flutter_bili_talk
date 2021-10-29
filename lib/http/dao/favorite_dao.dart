import 'package:flutter_bili_talk/http/request/favorite_list_request.dart';
import 'package:flutter_bili_talk/http/request/favorite_request.dart';
import 'package:flutter_bili_talk/model/ranking_model.dart';
import 'package:hi_net/hi_net.dart';

class FavoriteDao {
  static favorite(String vid, bool isFavReq) async {
    FavoriteRequest request = FavoriteRequest(isFavReq);
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print('favorite request result: $result');
    return result;
  }

  /// 收藏列表
  static favoriteList({int pageIndex = 1, int pageSize = 10}) async {
    FavoriteListRequest request = FavoriteListRequest();
    request.add('pageIndex', pageIndex).add('pageSize', pageSize);
    var result = await HiNet.getInstance().fire(request);
    return RankingModel.fromJson(result['data']);
  }
}
