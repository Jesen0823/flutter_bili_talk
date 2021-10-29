import 'dart:convert';

import 'package:flutter_bili_talk/http/request/hi_base_request.dart';

abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(HiBaseRequest request);
}

/// 统一返回处理
class HiNetResponse<T> {
  T data;
  HiBaseRequest request;
  int statusCode;
  String statusMessage;
  // 其他类型
  dynamic extra;

  HiNetResponse(
      {this.data,
      this.statusCode,
      this.request,
      this.statusMessage,
      this.extra});

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
