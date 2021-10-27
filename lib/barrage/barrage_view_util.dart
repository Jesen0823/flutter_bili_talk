import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/model/barrage_model.dart';

/// 弹幕工具类
class BarrageViewUtil {
  // 定义弹幕样式
  static barrageView(BarrageModel model) {
    switch (model.type) {
      case 1:
        return _barrageTypeDefault(model);
    }
    return Text(
      model.content,
      style: TextStyle(color: Colors.white),
    );
  }
}

_barrageTypeDefault(BarrageModel model) {
  return Center(
    child: Container(
      child: Text(
        model.content,
        style: TextStyle(color: Colors.deepOrangeAccent),
      ),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(15)),
    ),
  );
}
