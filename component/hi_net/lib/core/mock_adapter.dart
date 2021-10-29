import 'package:hi_net/request/hi_base_request.dart';

import 'hi_response.dart';

/// 测试适配器 mock数据

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(HiBaseRequest request) {
    return Future<HiNetResponse>.delayed(Duration(milliseconds: 1000), () {
      return HiNetResponse(data: {
        {"code": 0, "message": "success"}
      }, statusCode: 200);
    });
  }
}
