import 'hi_base_request.dart';

class VideoDetailRequest extends HiBaseRequest {
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
    return 'uapi/fa/detail';
  }
}
