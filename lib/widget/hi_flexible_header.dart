import 'package:flutter/material.dart';
import 'package:hi_base/view_util.dart';

/// 可以动态改变位置的Header组件
/// 单独抽取出来，达到局部刷新，避免整个大的Widget多次重绘，优化性能
class HiFlexibleHeader extends StatefulWidget {
  final String name;
  final String face;
  final ScrollController controller;

  const HiFlexibleHeader(
      {Key key, @required this.name, this.face, @required this.controller})
      : super(key: key);

  @override
  _HiFlexibleHeaderState createState() => _HiFlexibleHeaderState();
}

class _HiFlexibleHeaderState extends State<HiFlexibleHeader> {
  // header距离底部的距离
  static const double MAX_BOTTOM = 40;
  static const double MIN_BOTTOM = 10;

  // 滚动范围
  static const MAX_OFFSET = 80;
  // 动态距离
  double _currentBottom = MAX_BOTTOM;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      var offset = widget.controller.offset;
      print('offset: $offset');
      // 计算padding变化
      var curOffset = (MAX_OFFSET - offset) / MAX_OFFSET;
      var dy = curOffset * (MAX_BOTTOM - MIN_BOTTOM);
      // 临界值保护
      if (dy > (MAX_BOTTOM - MIN_BOTTOM)) {
        dy = MAX_BOTTOM - MIN_BOTTOM;
      } else if (dy < 0) {
        dy = 0;
      }
      setState(() {
        // 计算实际padding
        _currentBottom = MIN_BOTTOM + dy;
      });
      print('_currentBottom: $_currentBottom');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(bottom: _currentBottom, left: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: cachedImage(widget.face, width: 46, height: 46),
          ),
          hiSpace(width: 8),
          Text(
            widget.name,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
