import 'hi_base_request.dart';

/// 个人中心页面请求
class ProfileRequest extends HiBaseRequest {
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
    return 'uapi/fa/profile';
  }
}
