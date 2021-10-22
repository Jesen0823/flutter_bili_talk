import 'package:flutter_bili_talk/db/hi_cache.dart';
import 'package:flutter_bili_talk/http/request/base_request.dart';

class LoginApi extends BaseRequest {
  //登陆
  /* static login(String username, String password) {
    return _send(username, password);
  }*/

  //注册
  /*static registration(
      String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }*/

  //发送请求
  /*static _send(String userName, String password, {imoocId, orderId}) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
    } else {
      request = LoginRequest();
    }
    request
        .add("userName", userName)
        .add("password", password)
        .add("imoocId", imoocId)
        .add("orderId", orderId);
    var fire = await HiNet.getInstance().fire(request);
    print("LoginApi: send():" + fire.toString());
    if (fire['code'] == 0 && fire['data'] != null) {
      //保存登陆令牌
      HiCache.getInstance().setString(BOARDING_PASS, fire['data']);
    }
    return fire;
  }*/

  static getBoardingPass() {
    return HiCache.getInstance().get(BOARDING_PASS);
  }

  static String BOARDING_PASS = 'boarding-pass';

  @override
  HttpMethod httpMethod() {
    // TODO: implement httpMethod
    throw UnimplementedError();
  }

  @override
  bool needLogin() {
    // TODO: implement needLogin
    throw UnimplementedError();
  }

  @override
  String path() {
    // TODO: implement path
    throw UnimplementedError();
  }
}
