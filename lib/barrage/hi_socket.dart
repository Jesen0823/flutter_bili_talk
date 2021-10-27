import 'package:flutter/cupertino.dart';
import 'package:flutter_bili_talk/http/dao/login_dao.dart';
import 'package:flutter_bili_talk/model/barrage_model.dart';
import 'package:flutter_bili_talk/util/hi_contants.dart';
import 'package:web_socket_channel/io.dart';

/// WebSocket通信封装
class HiSocket implements ISocket {
  static const _URL = 'wss://api.devio.org/uapi/fa/barrage/';
  IOWebSocketChannel _channel;
  ValueChanged<List<BarrageModel>> _callBack;

  //心跳间隔秒数，根据服务器实际timeout时间来调整，这里Mginx服务器的timeout为60秒,Mginx超时后会关闭连接 所以websocket超时时间小于Mginx即可 但不建议设置太小会增加服务器的压力
  int _intervalSeconds = 50;

  @override
  void close() {
    if (_channel != null) {
      _channel.sink.close();
    }
  }

  @override
  ISocket listen(callBack) {
    _callBack = callBack;
    return this;
  }

  @override
  ISocket open(String vid) {
    _channel = IOWebSocketChannel.connect(_URL + vid,
        headers: _headers(), pingInterval: Duration(seconds: _intervalSeconds));
    _channel.stream.handleError((error) {
      print('[Flut] socket error: $error');
    }).listen((message) {
      _handleMessage(message);
    });
  }

  @override
  ISocket send(String message) {
    _channel.sink.add(message);
    return this;
  }

  _headers() {
    Map<String, dynamic> header = {
      HiConstants.authTokenK: HiConstants.authTokenV,
      HiConstants.courseFlagK: HiConstants.courseFlagV,
    };
    header[LoginDao.BOARDING_PASS] = LoginDao.getBoardingPass();
    return header;
  }

  /// 处理弹幕返回
  void _handleMessage(event) {
    print('[Flut] socket message: $event');
    var result = BarrageModel.fromJsonString(event);
    if (result != null && _callBack != null) {
      _callBack(result);
    }
  }
}

abstract class ISocket {
  // 和服务器建立连接
  ISocket open(String vid);

  // 发送弹幕
  ISocket send(String message);

  // 关闭连接
  void close();

  // 接收弹幕
  ISocket listen(ValueChanged<List<BarrageModel>> callBack);
}
