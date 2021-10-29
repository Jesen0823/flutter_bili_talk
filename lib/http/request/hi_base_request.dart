enum HttpMethod { GET, POST, DELETE }

/// 基础请求
abstract class HiBaseRequest {
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

    print('[Flut] 请求url:$uri');
    print('[Flut] 请求头:$header');
    print('[Flut] 请求参:$params');
    return uri.toString();
  }

  /// 添加参数
  HiBaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  /// 请求头
  Map<String, dynamic> header = {};

  /// 添加Header
  HiBaseRequest addHeader(String k, Object v) {
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
