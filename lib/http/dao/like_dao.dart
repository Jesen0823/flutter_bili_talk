import 'package:flutter_bili_talk/http/request/base_request.dart';
import 'package:flutter_bili_talk/http/request/like_request.dart';
import 'package:hi_net/hi_net.dart';

/// 点赞/取消点赞
class LikeDao {
  static like(String vid, bool like) async {
    BaseRequest request = LikeRequest(like);
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    return result;
  }
}
