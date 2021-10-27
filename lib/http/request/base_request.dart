import 'package:flutter_bili_talk/http/dao/login_dao.dart';
import 'package:flutter_bili_talk/util/hi_contants.dart';

enum HttpMethod { GET, POST, DELETE }

/// 基础请求
abstract class BaseRequest {
  // curl -X GET "http://api.deviQ.org/uapi/test/test7reguestPrans=11" -H "accept: */*"
  // curl -X GET "https://api.devio.org/uapi/test/test/1

  var pathParams;
  var useHttps = true;
  Map<String, String> params = Map();

  bool needLogin();

  String authority() {
    return "api.devio.org";
  }

  // 设置POST/GET
  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    // 拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }
    // http和https切换
    bool flag = isEmpty(params);
    if (useHttps) {
      uri = !flag
          ? Uri.https(authority(), pathStr, params)
          : Uri.https(authority(), pathStr);
    } else {
      uri = !flag
          ? Uri.http(authority(), pathStr, params)
          : Uri.http(authority(), pathStr);
    }

    // 给需要登录的接口携带登录令牌
    var boardingPass = LoginDao.getBoardingPass();
    if (needLogin() && boardingPass != null) {
      // 给需要登录的接口携带登录令牌
      addHeader(LoginDao.BOARDING_PASS, boardingPass);
    }
    print('[Flut] 请求url:$uri');
    print('[Flut] 请求头:$header');
    print('[Flut] 请求参:$params');
    return uri.toString();
  }

  /// 添加参数
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  /// 请求头
  Map<String, dynamic> header = {
    //∥访问令牌，在课程公告获取
    HiConstants.authTokenK: HiConstants.authTokenV,
    HiConstants.courseFlagK: HiConstants.courseFlagV,
  };

  /// 添加Header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }

  /// 检查对象或 List 或 Map 是否为空
  bool isEmpty(Object object) {
    if (object is String && object.isEmpty) {
      return true;
    } else if (object is List && object.isEmpty) {
      return true;
    } else if (object is Map && object.isEmpty) {
      return true;
    }
    return false;
  }
}
