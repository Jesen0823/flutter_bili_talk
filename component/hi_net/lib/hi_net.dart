import 'package:hi_net/request/hi_base_request.dart';

import 'core/dio_adapter.dart';
import 'core/hi_error.dart';
import 'core/hi_response.dart';

class HiNet {
  HiNet._();

  static HiNet _instance;
  static HiNet getInstance() {
    if (_instance == null) {
      _instance = HiNet._();
    }
    return _instance;
  }

  Future fire(HiBaseRequest request) async {
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
    var result = response?.data;
    print('[Flut] fire result: $response');

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
  }

  Future<dynamic> send<T>(HiBaseRequest request) async {
    print("[Flut] url:${request.url()}");
    // HiNetAdapter adapter = MockAdapter(); // 使用http
    HiNetAdapter adapter = DioAdapter(); // 使用Dio网络请求库
    return adapter.send(request);
  }

  void printLog(log) {
    print('[Flut] hi_net: ${log.toString()}');
  }
}
