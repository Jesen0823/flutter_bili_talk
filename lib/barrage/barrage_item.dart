import 'package:flutter/material.dart';

import 'barrage_transition.dart';

/// 单条弹幕Widget
class BarrageItem extends StatelessWidget {
  final String id;
  final double top;
  final Widget child;
  // 播放完成
  final ValueChanged onComplete;
  // 弹幕滚动时长
  final Duration duration;

  // key 防止动画错乱
  var _key = GlobalKey<BarrageTransitionState>();

  BarrageItem(
      {Key key,
      this.id,
      this.top,
      this.child,
      this.onComplete,
      this.duration = const Duration(milliseconds: 9000)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        top: top,
        child: BarrageTransition(
          key: _key,
          child: child,
          onComplete: (V) {
            onComplete(id);
          },
          duration: duration,
        ));
  }
}
