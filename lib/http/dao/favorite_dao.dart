import 'package:flutter_bili_talk/http/core/hi_net.dart';
import 'package:flutter_bili_talk/http/request/base_request.dart';
import 'package:flutter_bili_talk/http/request/favorite_request.dart';

class FavoriteDao {
  static favorite(String vid, bool isFavReq) async {
    BaseRequest request = FavoriteRequest(isFavReq);
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print('favorite request result: $result');
    return result;
  }
}
