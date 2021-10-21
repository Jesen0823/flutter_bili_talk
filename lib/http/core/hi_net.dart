import 'package:flutter_bili_talk/http/core/mock_adapter.dart';
import 'package:flutter_bili_talk/http/request/base_request.dart';

import 'hi_error.dart';
import 'hi_response.dart';

class HiNet {
  HiNet._();

  static HiNet _instance;
  static HiNet getInstance() {
    if (_instance == null) {
      _instance = HiNet._();
    }
    return _instance;
  }

  Future fire(BaseRequest request) async {
    HiNetResponse response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      // 其他异常
      error = e;
      printLog(e);
    }

    if (response == null) {
      printLog(error);
    }
    var result = response.data;
    print('[Flut] fire result: $result');

    var status = response.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status, result.toString(), data: result);
    }
    return result;
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    print("[Flut] url:${request.url()}");
    HiNetAdapter adapter = MockAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print('[Flut] hi_net: ${log.toString()}');
  }
}
