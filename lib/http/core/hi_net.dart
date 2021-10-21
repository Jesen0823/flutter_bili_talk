import 'package:flutter_bili_talk/http/request/base_request.dart';

class HiNet {
  HiNet._();

  static HiNet? _instance;
  static HiNet getInstance() {
    if (_instance == null) {
      _instance = HiNet._();
    }
    return _instance!;
  }

  Future fire(BaseRequest request) async {
    var response = await send(request);
    var result = response['data'];
    print('[Flut] fire result: $result');
    return result;
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    print("[Flut] url:${request.url()}");
    print("[Flut] method:${request.httpMethod()}");

    request.addHeader("token", "123");
    print('[Flut] header: ${request.header}');
    return Future.value({
      "statusCode": 200,
      "data": {"code": 0, "message": "success"}
    });
  }

  void printLog(log) {
    print('[Flut] hi_net: ${log.toString()}');
  }
}
