import 'package:flutter/cupertino.dart';

/// 页面状态管理
abstract class HiState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(fn) {
    // 如果当前页面被加载
    if (mounted) {
      super.setState(fn);
    } else {
      print('HiState， page unDistray ,setState不执行, ${toString()}');
    }
  }
}
