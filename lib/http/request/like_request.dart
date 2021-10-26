import 'package:flutter_bili_talk/http/request/base_request.dart';

/// 点赞接口
class LikeRequest extends BaseRequest {
  // 是否要点赞
  bool isReqLike = true;

  LikeRequest(this.isReqLike);

  @override
  HttpMethod httpMethod() {
    if (isReqLike) {
      return HttpMethod.POST;
    } else {
      return HttpMethod.DELETE;
    }
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return 'uapi/fa/like';
  }
}
