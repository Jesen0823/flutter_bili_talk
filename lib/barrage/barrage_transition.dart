import 'package:flutter/material.dart';

/// 弹幕移动特效
///
class BarrageTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final ValueChanged onComplete;

  const BarrageTransition(
      {Key key, @required this.child, @required this.duration, this.onComplete})
      : super(key: key);

  @override
  BarrageTransitionState createState() => BarrageTransitionState();
}

// 不设为私有，因为barrage_item里面要用到
class BarrageTransitionState extends State<BarrageTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // 创建动画控制器
    _animationController =
        AnimationController(duration: widget.duration, vsync: this)
          ..addStatusListener((status) {
            // 动画状态执行完毕回调
            if (status == AnimationStatus.completed) {
              widget.onComplete('');
            }
          });
    // 定义从右向左补间动画
    var begin = Offset(1.0, 0);
    var end = Offset(-1.0, 0);
    _animation = Tween(begin: begin, end: end).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
