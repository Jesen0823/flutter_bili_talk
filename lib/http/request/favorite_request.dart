import 'hi_base_request.dart';

/// 收藏请求
class FavoriteRequest extends HiBaseRequest {
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
