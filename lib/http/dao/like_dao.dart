import 'package:flutter_bili_talk/http/core/hi_net.dart';
import 'package:flutter_bili_talk/http/request/hi_base_request.dart';
import 'package:flutter_bili_talk/http/request/like_request.dart';

/// 点赞/取消点赞
class LikeDao {
  static like(String vid, bool like) async {
    HiBaseRequest request = LikeRequest(like);
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    return result;
  }
}
