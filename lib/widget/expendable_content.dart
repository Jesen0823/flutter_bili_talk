import 'package:flutter/material.dart';
import 'package:flutter_bili_talk/model/video_model.dart';
import 'package:hi_base/view_util.dart';

/// 可展开带动画的Widget

class ExpandableContent extends StatefulWidget {
  final VideoModel videoModel;
  const ExpandableContent({Key key, this.videoModel}) : super(key: key);

  @override
  _ExpandableContentState createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  bool _expand = false;

  // 用来管理Animation
  AnimationController _controller;

  // 生成动画高度的值
  Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(microseconds: 200), vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _controller.addListener(() {
      // 监听动画值的变化
      print('[Flut] animation: ${_heightFactor.value}');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
      child: Column(
        children: [
          _buildTitle(),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
          ),
          _buildVideoInfo(),
          _buildVideoDes(),
        ],
      ),
    );
  }

  _buildTitle() {
    return InkWell(
      onTap: _toggleExpand,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 通过Expanded让Text获取最大宽度
          Expanded(
            child: Text(
              widget.videoModel.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
          ),
          Icon(
            _expand
                ? Icons.keyboard_arrow_up_sharp
                : Icons.keyboard_arrow_down_sharp,
            color: Colors.grey,
            size: 16,
          ),
        ],
      ),
    );
  }

  void _toggleExpand() {
    setState(() {
      _expand = !_expand;
      if (_expand) {
        _controller.forward();
      } else {
        // 方向执行
        _controller.reverse();
      }
    });
  }

  /// 视频信息介绍
  _buildVideoInfo() {
    var style = TextStyle(fontSize: 12, color: Colors.grey);
    var dateStr = widget.videoModel.createTime.length > 10
        ? widget.videoModel.createTime.substring(5, 10)
        : widget.videoModel.createTime;
    return Row(
      children: [
        ...smallIconText(Icons.ondemand_video, widget.videoModel.view),
        Padding(
          padding: EdgeInsets.only(left: 10),
        ),
        ...smallIconText(Icons.list_alt, widget.videoModel.reply),
        Text(
          ' $dateStr',
          style: style,
        ),
      ],
    );
  }

  /// 视频详细描述
  _buildVideoDes() {
    var child = _expand
        ? Text(
            widget.videoModel.desc,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        : null;

    return AnimatedBuilder(
      animation: _controller.view,
      child: child,
      builder: (BuildContext context, Widget child) {
        return Align(
          heightFactor: _heightFactor.value,
          // fixBug 从布局之上位置开始展开
          alignment: Alignment.topCenter,
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 8),
            child: child,
          ),
        );
      },
    );
  }
}
