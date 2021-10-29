import 'package:flutter_bili_talk/http/request/ranking_request.dart';
import 'package:flutter_bili_talk/model/ranking_model.dart';
import 'package:hi_net/hi_net.dart';

class RankingDao {
  static get(String sort, {int pageIndex = 1, int pageSize = 10}) async {
    RankingRequest request = RankingRequest();
    request
        .add("sort", sort)
        .add("pageSize", pageSize)
        .add("pageIndex", pageIndex);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return RankingModel.fromJson(result["data"]);
  }
}
