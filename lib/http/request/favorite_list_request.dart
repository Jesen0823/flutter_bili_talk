import 'hi_base_request.dart';

/// 收藏列表请求
class FavoriteListRequest extends HiBaseRequest {
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
