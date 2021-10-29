import 'package:hi_net/request/hi_base_request.dart';

import 'base_request.dart';

/// 收藏列表请求
class FavoriteListRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return "uapi/fa/favorites";
  }
}
