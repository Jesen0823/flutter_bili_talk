import 'package:flutter_bili_talk/http/request/home_request.dart';
import 'package:flutter_bili_talk/model/home_model.dart';
import 'package:hi_net/hi_net.dart';

class HomeDao {
  static Future<HomeMo> get(String categoryName,
      {int pageIndex = 1, int pageSize = 10}) async {
    HomeRequest request = HomeRequest();
    request.pathParams = categoryName;
    request.add('pageIndex', pageIndex).add('pageSize', pageSize);
    var result = await HiNet.getInstance().fire(request);
    return HomeMo.fromJson(result['data']);
  }
}
