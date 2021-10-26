import 'package:flutter_bili_talk/http/request/base_request.dart';

/// 收藏请求
class FavoriteRequest extends BaseRequest {
  // 是否要收藏
  bool isReqFav = true;

  FavoriteRequest(this.isReqFav);

  @override
  HttpMethod httpMethod() {
    if (isReqFav) {
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
    return 'uapi/fa/favorite';
  }
}
