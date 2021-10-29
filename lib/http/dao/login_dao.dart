import 'package:flutter_bili_talk/db/hi_cache.dart';
import 'package:flutter_bili_talk/http/core/hi_net.dart';
import 'package:flutter_bili_talk/http/request/hi_base_request.dart';
import 'package:flutter_bili_talk/http/request/login_request.dart';
import 'package:flutter_bili_talk/http/request/registration_request.dart';

class LoginDao {
  // 登录令牌
  static String BOARDING_PASS = 'boarding-pass';

  static login(String userName, String password) {
    return _send(userName, password);
  }

  static registration(
      String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  /// 封装登录注册方法
  static _send(String userName, String password, {imoocId, orderId}) async {
    HiBaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
    } else {
      request = LoginRequest();
    }

    request
        .add('userName', userName)
        .add('password', password)
        .add('imoocId', imoocId)
        .add('orderId', orderId);

    var result = await HiNet.getInstance().fire(request);
    print(result);
    if (result['code'] == 0 && result['data'] != null) {
      // 保存登录lingp
      HiCache.getInstance().setString(BOARDING_PASS, result['data']);
    }
    return result;
  }

  static getBoardingPass() {
    return HiCache.getInstance().get(BOARDING_PASS);
  }
}
