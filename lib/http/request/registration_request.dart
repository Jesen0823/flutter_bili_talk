import 'package:hi_net/request/hi_base_request.dart';

import 'base_request.dart';

/// 注册请求

class RegistrationRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return '/uapi/user/registration';
  }
}
