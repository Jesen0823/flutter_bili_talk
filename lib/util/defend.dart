import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 异常处理工具
///
class HiDefend {
  run(Widget app) {
    // 框架异常
    FlutterError.onError = (FlutterErrorDetails details) async {
      // 线上环境,上报;否则直接输出
      if (kReleaseMode) {
        Zone.current.handleUncaughtError(details.exception, details.stack);
      } else {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    runZonedGuarded(() {
      runApp(app);
    }, (e, s) => _reportError(e, s));
  }

  ///通过接口上报服务端异常,比如三方Buggly
  _reportError(Object error, StackTrace s) {
    print('是否线上环境 KReleaseMode: $kReleaseMode');
    print('catch error:$error');
  }
}
